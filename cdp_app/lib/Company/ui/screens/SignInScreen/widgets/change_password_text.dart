import 'package:cdp_app/Company/ui/screens/ChangePasswordScreen/change_password_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChangePasswordText extends StatelessWidget {
  const ChangePasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Olvidaste tu contraseña?"),
        TextButton(
          onPressed: () {
            Navigator.push(
            context,
            PageTransition(
              child: const ChangePasswordScreen(),
              type: PageTransitionType.bottomToTop,
            ),
          );
          },
          child: const Text(
            "Cambiar contraseña",
            style: TextStyle(color: darkColor),
          ),
        )
      ],
    );
  }
}
