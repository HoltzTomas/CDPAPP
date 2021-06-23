import 'package:cdp_app/PDF/models/pdf_file.dart';
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
}