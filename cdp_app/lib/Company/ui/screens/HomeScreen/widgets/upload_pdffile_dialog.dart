import 'dart:io';

import 'package:cdp_app/PDF/repository/pdf_cloud_repository.dart';
import 'package:cdp_app/PDF/repository/pdf_storage_repository.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  bool error = false;
  final PdfStorageRepository _pdfStorageRepository = PdfStorageRepository();

  Widget uploadFileButton(BuildContext context) => TextButton(
        onPressed: () {
          if (fileName.isNotEmpty) {
            setState(
              () {
                isLoading = true;
                error = false;
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
          } else {
            setState(() {
              error = true;
            });
          }
        },
        child: isLoading
            ? const Text(
                "Cargando, no cierre esta ventana...",
                style: TextStyle(color: darkColor),
              )
            : const Text(
                "Subir",
                style: TextStyle(color: darkColor),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      button: uploadFileButton(context),
      child: boxContent(),
    );
  }

  Widget boxContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Ponle nombre el archivo que importaste",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding),
        TextField(
          onChanged: (value) {
            fileName = value;
          },
          maxLength: 20,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          decoration: InputDecoration(hintText: "Nombre", errorText: error ? "Ingrese un nombre" : null),
        ),
      ],
    );
  }
}
