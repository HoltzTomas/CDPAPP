import 'dart:io';

import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/Company/ui/screens/HomeScreen/widgets/upload_pdffile_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthRepository authRepository = AuthRepository();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(auth.currentUser!.email!),
            accountName: Text(auth.currentUser!.displayName!),
            currentAccountPicture: SvgPicture.asset(
              "assets/icons/iconoTractor.svg",
              color: Colors.white,
            ),
            decoration: const BoxDecoration(color: primaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text("Subir cartas de porte"),
            onTap: () async {
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
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar Sesion"),
            onTap: () {
              authRepository.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
