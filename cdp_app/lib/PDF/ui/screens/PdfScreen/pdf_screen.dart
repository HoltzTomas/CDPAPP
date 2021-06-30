import 'package:cdp_app/CDP/repository/cdp_cloud_repository.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/emitir_cdp_fab.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/icons_references_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            return SingleChildScrollView(
              child: Column(children: [
                ...cdpCloudRepository.buildCDPs(
                  list: snapshot.data!.docs,
                  userFile: userFile,
                ),
                const SizedBox(height: defaultPadding * 2),
              ]),
            );
        }
      },
    );
  }

  Widget avaiblesText() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc(userFile.pdfName)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(child: Text("No hay coneccion a internet"));
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Text(
              "Disponibles: ${snapshot.data!.get('availableCDPs').toString()}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(userFile.pdfName),
          actions: [
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const IconReferencesDialog());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: defaultPadding),
                  child: avaiblesText(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                  child: const Text(
                    "Tip: Al copiar una carta de porte debera volver a colocar su firma.",
                    textAlign: TextAlign.center,
                  ),
                ),
                emitedCdpsList(),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: userFile.availableCDPs > 0
            ? EmitirCdpFAB(
                selectedFile: userFile,
              )
            : null);
  }
}
