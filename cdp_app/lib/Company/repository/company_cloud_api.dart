import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CompanyCloudApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> sendAnonymousComment(
      {required String comment, required BuildContext context}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final DocumentReference<Map<String, dynamic>> reference =
          firebaseFirestore
              .collection('anonymousComments')
              .doc(Timestamp.now().toString());

      await reference.set({'message': comment});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          content: Text("Comentario enviado con exito!!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "No hay conexión a internet",
          ),
        ),
      );
    }
  }
}
