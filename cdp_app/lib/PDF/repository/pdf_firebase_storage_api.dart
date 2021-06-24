import 'dart:io';

import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/repository/pdf_cloud_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfFirebaseStorageAPI {
  final Reference reference = FirebaseStorage.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PdfCloudRepository cloudRepository = PdfCloudRepository();

  Future<void> uploadFile(
      String fileName, File userFile, BuildContext context) async {
    final UploadTask uploadTask =
        reference.child("${auth.currentUser!.uid}/$fileName").putFile(userFile);

    final taskSnapshot = await uploadTask;

    final int fileNumOfPages =
        PdfDocument(inputBytes: userFile.readAsBytesSync()).pages.count;

    final PdfFile file = PdfFile(
      pdfUrl: "${auth.currentUser!.uid}/$fileName",
      pdfName: fileName,
      availableCDPs: fileNumOfPages / 4,
      issuedCDPs: 0,
      time: Timestamp.now(),
    );

    cloudRepository.uploadPdfFile(file);
  }
}
