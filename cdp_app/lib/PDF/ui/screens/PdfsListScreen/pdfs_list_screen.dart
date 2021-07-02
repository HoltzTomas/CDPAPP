import 'package:cdp_app/PDF/repository/pdf_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfsListScreen extends StatefulWidget {
  ///Here we have a list of the PdfFiles that the user uploaded to Firebase
  const PdfsListScreen({Key? key}) : super(key: key);

  @override
  _PdfsListScreenState createState() => _PdfsListScreenState();
}

class _PdfsListScreenState extends State<PdfsListScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PdfCloudRepository cloudRepository = PdfCloudRepository();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(currentUser!.uid)
            .doc('pdfs')
            .collection('pdfFiles')
            .orderBy('time', descending: false)
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
              if (snapshot.data!.docs.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: defaultPadding / 2),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: const Text(
                        "¡No subiste ningun archivo con cartes de porte aun!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              } else {
                return ListView(
                  children: [
                    ...cloudRepository.buildUploadedFileItems(
                        list: snapshot.data!.docs),
                    const SizedBox(height: defaultPadding * 2),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
