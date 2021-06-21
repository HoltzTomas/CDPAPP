import 'dart:async';

import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/Company/ui/screens/VerifyEmailScreen/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailHandler extends StatefulWidget {
  const VerifyEmailHandler({Key? key}) : super(key: key);

  @override
  _VerifyEmailHandlerState createState() => _VerifyEmailHandlerState();
}

class _VerifyEmailHandlerState extends State<VerifyEmailHandler> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late User user;

  late Timer timer;

  late Widget homeWidget;

  @override
  void initState() {
    final AuthRepository authRepository = AuthRepository();
    user = auth.currentUser!;
    if (!user.emailVerified) {
      homeWidget = const VerifyEmailScreen();
      user.sendEmailVerification();
    } else {
      homeWidget = Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                authRepository.signOut();
              },
              child: const VerifyEmailHandler(),
            ),
          ),
        );
    }
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return homeWidget;
  }

  Future<void> checkEmailVerified() async {
    final AuthRepository authRepository = AuthRepository();
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      setState(() {
        homeWidget = Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                authRepository.signOut();
              },
              child: const VerifyEmailHandler(),
            ),
          ),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verificado con exito')));
    }
  }
}
