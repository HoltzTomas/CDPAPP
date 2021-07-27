import 'dart:io';

import 'package:cdp_app/Company/ui/screens/HomeScreen/widgets/upload_pdffile_dialog.dart';
import 'package:cdp_app/PDF/providers/pdf_providers.dart';
import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<bool> isLoading = StateProvider<bool>((ref) => false);
final StateProvider<String> buttonText =
    StateProvider<String>((ref) => "Subir archivo con cartas de porte");

class UploadCdpsFAB extends ConsumerWidget {
  const UploadCdpsFAB({Key? key}) : super(key: key);

  Future<void> pickFile(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final File file = File(result.files.single.path!);
      showDialog(
        context: context,
        builder: (context) {
          return UploadPdfFileDialog(userFile: file);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () async {
          final connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            if (watch(isSubActive).state == true) {
              pickFile(context);
            } else {
              context.read(buttonText).state = "Cargando...";
              final pdfFilesUploaded = await FirebaseFirestore.instance
                  .collection(FirebaseAuth.instance.currentUser!.uid)
                  .doc('pdfs')
                  .get()
                  .then(
                (value) {
                  context.read(buttonText).state =
                      "Subir archivo con cartas de porte";
                  return value['pdfFilesUploaded'] + 1 as int;
                },
              );

              if (pdfFilesUploaded < 3) {
                pickFile(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: primaryColor,
                    content: Text(
                      "Alcanzaste el limite disponible para el plan gratuito",
                    ),
                  ),
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: primaryColor,
                content: Text(
                  "No hay conexión a internet",
                ),
              ),
            );
          }
        },
        child: Text(
          watch(buttonText).state,
          style: const TextStyle(color: darkColor),
        ),
      ),
    );
  }
}
