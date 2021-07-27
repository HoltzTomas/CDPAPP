import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class FirebaseAuthAPI {
  ///SignUp a new user using Firebase Email Authentication
  Future<User?> signUpWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        userCredential.user!.updateDisplayName(name);
        Navigator.pop(context);
        FirebaseFirestore.instance
            .collection(userCredential.user!.uid)
            .doc('pdfs')
            .set({'pdfFilesUploaded': 0});
        Purchases.logIn(FirebaseAuth.instance.currentUser!.uid);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("La Contraseña es muy debil")));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Esta cuenta de E-Mail ya esta en uso')));
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('La dirección de e-mail no es valida')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('A ocurrido un error')));
      }
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

  ///SignIn a user using Firebase Email Authentication
  Future<User?> signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Purchases.logIn(FirebaseAuth.instance.currentUser!.uid);
        Navigator.pop(context);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Usuario no encontrado, crea una cuenta.')));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contraseña equivocada')));
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('La dirección de e-mail no es valida')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('A ocurrido un error')));
      }
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

  ///SignOut user using Firebase Authentication service
  Future signOut(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Purchases.logOut().whenComplete(() => FirebaseAuth.instance.signOut());
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

  ///Changes user password
  Future<void> changeUserPassword(
      {required String email, required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email enviado a $email'),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No existe la cuenta $email')));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('La dirección de e-mail no es valida')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Ocurrió un error')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ocurrió un error')));
    }
  }
}
