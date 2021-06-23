import 'dart:io';

import 'package:cdp_app/PDF/repository/pdf_firebase_storage_api.dart';
import 'package:flutter/material.dart';

class PdfStorageRepository {
  final PdfFirebaseStorageAPI storageAPI = PdfFirebaseStorageAPI();

  Future<void> uploadFile(String fileName, File userFile, BuildContext context) async =>
      storageAPI.uploadFile(fileName, userFile, context);
}
