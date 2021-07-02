import 'dart:io';

import 'package:cdp_app/Company/ui/screens/HomeScreen/widgets/upload_pdffile_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadCdpsFAB extends StatelessWidget {
  const UploadCdpsFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () async{
          final FilePickerResult? result =
                  await FilePicker.platform.pickFiles();
              if (result != null) {
                final File file = File(result.files.single.path!);
                showDialog(
                  context: context,
                  builder: (context) {
                    return UploadPdfFileDialog(userFile: file);
                  },
                );
              }
        },
        child: const Text(
          "Subir archivo con cartas de porte",
          style: TextStyle(color: darkColor),
        ),
      ),
    );
  }
}
