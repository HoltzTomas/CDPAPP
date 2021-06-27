import 'package:cdp_app/PDF/providers/pdf_cloud_providers.dart';
import 'package:cdp_app/PDF/repository/pdf_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          print(currentUser);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text("No hay coneccion a internet"));
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView(
                children: cloudRepository.buildUploadedFileItems(
                    list: snapshot.data!.docs),
              );
          }
        },
      ),
    );
  }
}
