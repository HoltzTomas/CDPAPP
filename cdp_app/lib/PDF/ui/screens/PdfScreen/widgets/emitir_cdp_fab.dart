import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmitirCdpFAB extends StatelessWidget {
  const EmitirCdpFAB({Key? key, required this.selectedFile}) : super(key: key);

  final PdfFile selectedFile;

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
            return const Center(child: Text("No hay coneccion a internet"));
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: FormScreen(
                        pdfFile: PdfFile(
                          pdfUrl: snapshot.data!.get('pdfUrl') as String,
                          pdfName: snapshot.data!.get('pdfName') as String,
                          availableCDPs: snapshot.data!.get('availableCDPs') as double,
                          issuedCDPs: snapshot.data!.get('issuedCDPs') as double,
                          time: snapshot.data!.get('time') as Timestamp
                        ),
                      ),
                    ),
                  );
                  context.read(isCdpBeingEdited).state = false;
                },
                child: const Text(
                  "Emitir carta de porte",
                  style: TextStyle(color: darkColor),
                ),
              ),
            );
        }
      },
    );
  }
}
