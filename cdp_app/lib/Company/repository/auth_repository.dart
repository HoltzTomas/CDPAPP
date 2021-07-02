import 'package:cdp_app/Company/repository/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuthAPI _firebaseAuthAPI = FirebaseAuthAPI();

  ///SignUp a new user using Firebase Email Authentication
  Future<User?> signUpWithEmailAndPassword(
          {required BuildContext context,
          required String email,
          required String password,
          required String name}) async =>
      _firebaseAuthAPI.signUpWithEmailAndPassword(
          context: context, email: email, password: password, name: name);

  ///SignIn a user using Firebase Email Authentication
  Future<User?> signInWithEmailAndPassword(
          {required BuildContext context,
          required String email,
          required String password}) async =>
      _firebaseAuthAPI.signInWithEmailAndPassword(
          context: context, email: email, password: password);

  ///SignOut user using Firebase Authentication service
  Future signOut(BuildContext context) async =>
      _firebaseAuthAPI.signOut(context);

  Future<void> changeUserPassword(
      {required String email, required BuildContext context}) async=>
      _firebaseAuthAPI.changeUserPassword(email: email, context: context);
}
