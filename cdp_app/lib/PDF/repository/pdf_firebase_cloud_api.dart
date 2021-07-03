import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsListScreen/widgets/uploaded_file_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PdfFirebaseCloudApi {
  final FirebaseFirestore firebaseCloud = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> uploadPdfFile(PdfFile file, BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final pdfFilesUploaded = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc('pdfs')
          .get()
          .then((value) => value['pdfFilesUploaded'] + 1 as int);

      firebaseCloud
          .collection(currentUser!.uid)
          .doc('pdfs')
          .set({
            'pdfFilesUploaded': pdfFilesUploaded
          });

      firebaseCloud
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc('$pdfFilesUploaded. ${file.pdfName}')
          .set(
        {
          'pdfUrl': file.pdfUrl,
          'pdfName': '$pdfFilesUploaded. ${file.pdfName}',
          'availableCDPs': file.availableCDPs,
          'issuedCDPs': file.issuedCDPs,
          'time': file.time,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay coneccion a internet')));
    }
  }

  List<UploadedFileItem> buildUploadedFileItems(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list}) {
    final List<UploadedFileItem> files = [];
    for (final pdf in list) {
      files.add(
        UploadedFileItem(
          userFile: PdfFile(
            pdfUrl: pdf.get('pdfUrl') as String,
            pdfName: pdf.get('pdfName') as String,
            availableCDPs: pdf.get('availableCDPs') as double,
            issuedCDPs: pdf.get('issuedCDPs') as double,
            time: pdf.get('time') as Timestamp,
          ),
        ),
      );
    }
    return files;
  }
}
