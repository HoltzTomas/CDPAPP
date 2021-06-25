import 'package:cdp_app/Company/ui/screens/SignUpScreen/signup_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tiene cuenta aun?"),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
            context,
            PageTransition(
              child: const SignUpScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
          },
          child: const Text(
            "Registarse",
            style: TextStyle(color: darkColor),
          ),
        )
      ],
    );
  }
}
