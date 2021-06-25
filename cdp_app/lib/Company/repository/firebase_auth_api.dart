import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        //final CompanyBloc companyBloc = BlocProvider.of<CompanyBloc>(context);
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        userCredential.user!.updateDisplayName(name);
        //companyBloc.createdCompanyCollection(email: email, name: name);
        Navigator.pop(context);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("La Contraseña es muy debil")));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Esta cuenta de E-Mail ya esta en uso')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('A ocurrido un error')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay coneccion a internet')));
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
        Navigator.pop(context);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Usuario no encontrado, crea una cuenta.')));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contraseña equivocada')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('A ocurrido un error')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay coneccion a internet')));
    }
  }

  ///SignOut user using Firebase Authentication service
  Future signOut(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await FirebaseAuth.instance.signOut();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay coneccion a internet')));
    }
  }
}
