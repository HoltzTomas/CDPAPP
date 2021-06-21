import 'package:cdp_app/Company/ui/screens/SignInScreen/signin_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignInText extends StatelessWidget {
  const SignInText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Ya tiene una cuenta?"),
        TextButton(
          onPressed: () {
            Navigator.push(
            context,
            PageTransition(
              child: const SignInScreen(),
              type: PageTransitionType.bottomToTop,
            ),
          );
          },
          child: const Text(
            "Inicie sesion",
            style: TextStyle(color: darkColor),
          ),
        )
      ],
    );
  }
}
