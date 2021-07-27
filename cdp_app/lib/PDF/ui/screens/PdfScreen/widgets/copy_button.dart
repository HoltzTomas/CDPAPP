import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/CDP/repository/cdp_api.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({Key? key, required this.selectedFile, required this.cdp}) : super(key: key);

  final PdfFile selectedFile;
  final CDP cdp;

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc(selectedFile.pdfName)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(child: Text("No hay conexión a internet"));
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Container(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      final CdpApi cdpApi = CdpApi();
                      cdpApi.copyCDP(
                        context,
                        pdfFile: PdfFile(
                            pdfUrl: snapshot.data!.get('pdfUrl') as String,
                            pdfName: snapshot.data!.get('pdfName') as String,
                            availableCDPs:
                                snapshot.data!.get('availableCDPs') as double,
                            issuedCDPs:
                                snapshot.data!.get('issuedCDPs') as double,
                            time: snapshot.data!.get('time') as Timestamp),
                        cdp: cdp,
                      );
                      context.read(isCdpBeingEdited).state = false;
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
