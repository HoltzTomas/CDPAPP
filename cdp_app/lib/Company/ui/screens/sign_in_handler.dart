import 'package:cdp_app/Company/ui/screens/WelcomeScreen/welcome_screen.dart';
import 'package:cdp_app/Company/ui/screens/verify_email_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInHandler extends ConsumerWidget {
  const SignInHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const WelcomeScreen();
        } else {
          return const VerifyEmailHandler();
        }
      },
    );
  }
}
