import 'dart:io';

import 'package:cdp_app/PDF/repository/pdf_cloud_repository.dart';
import 'package:cdp_app/PDF/repository/pdf_storage_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class UploadPdfFileDialog extends StatefulWidget {
  const UploadPdfFileDialog({Key? key, required this.userFile})
      : super(key: key);

  final File userFile;

  @override
  _UploadPdfFileDialogState createState() => _UploadPdfFileDialogState();
}

class _UploadPdfFileDialogState extends State<UploadPdfFileDialog> {
  String fileName = "";
  bool isLoading = false;
  final PdfStorageRepository _pdfStorageRepository = PdfStorageRepository();

  Widget uploadFileButton(BuildContext context) => TextButton(
        onPressed: () {
          setState(
            () {
              isLoading = true;
            },
          );
          _pdfStorageRepository
              .uploadFile(fileName, widget.userFile, context)
              .whenComplete(
            () {
              setState(
                () {
                  isLoading = false;
                },
              );
              Navigator.pop(context);
            },
          );
        },
        child:
            isLoading ? const CircularProgressIndicator() : const Text("Subir"),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Importar archivo"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            const Text("Ponle nombre el archivo que importaste"),
            const SizedBox(height: defaultPadding),
            TextField(
              onChanged: (value) {
                fileName = value;
              },
              decoration: const InputDecoration(hintText: "Nombre"),
            ),
          ],
        ),
      ),
      actions: [uploadFileButton(context)],
    );
  }
}
