import 'package:cdp_app/Company/ui/screens/SignUpScreen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CancelVerificationButton extends StatelessWidget {
  const CancelVerificationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return IconButton(
        onPressed: () {
          auth.currentUser!.delete();
          auth.signOut();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'La cuenta ${auth.currentUser!.email} no ha sido creada')));
          Navigator.push(
              context,
              PageTransition(
                  child: const SignUpScreen(),
                  type: PageTransitionType.bottomToTop));
        },
        icon: const Icon(Icons.arrow_back_ios),);
  }
}
