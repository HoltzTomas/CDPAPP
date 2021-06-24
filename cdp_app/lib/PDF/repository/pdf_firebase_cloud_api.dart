import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsScreen/widgets/uploaded_file_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PdfFirebaseCloudApi {
  final FirebaseFirestore firebaseCloud = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void uploadPdfFile(PdfFile file) {
    firebaseCloud
        .collection(currentUser!.uid)
        .doc('pdfs')
        .collection('pdfFiles')
        .doc(file.pdfName)
        .set(
      {
        'pdfUrl': "${currentUser!.uid}/${file.pdfName}",
        'pdfName': file.pdfName,
        'disponibles': file.disponibles,
        'emitidas': file.emitidas,
        'time': file.time,
      },
    );
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
            disponibles: pdf.get('disponibles') as double,
            emitidas: pdf.get('emitidas') as double,
            time: pdf.get('time') as Timestamp,
          ),
        ),
      );
    }
    return files;
  }
}
