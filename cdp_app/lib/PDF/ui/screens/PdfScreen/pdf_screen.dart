import 'package:cdp_app/CDP/repository/cdp_cloud_repository.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/emitir_cdp_fab.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({Key? key, required this.userFile}) : super(key: key);

  final PdfFile userFile;

  Widget emitedCdpsList() {
    final CdpCloudRepository cdpCloudRepository = CdpCloudRepository();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc(userFile.pdfName)
          .collection('emitedCdps')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(child: Text("No hay coneccion a internet"));
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Column(
              children: cdpCloudRepository.buildCDPs(
                list: snapshot.data!.docs,
                userFile: userFile,
              ),
            );
        }
      },
    );
  }

  Widget avaiblesText() => Text(
        "Disponibles: ${userFile.availableCDPs.round()}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(userFile.pdfName),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: defaultPadding),
              child: avaiblesText(),
            ),
            emitedCdpsList(),
          ],
        ),
      ),
      floatingActionButton: EmitirCdpFAB(
        selectedFile: userFile,
      ),
    );
  }
}
