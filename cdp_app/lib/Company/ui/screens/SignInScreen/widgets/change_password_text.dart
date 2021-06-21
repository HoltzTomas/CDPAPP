import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class ChangePasswordText extends StatelessWidget {
  const ChangePasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Olvidaste tu contraseña?"),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Cambiar contraseña",
            style: TextStyle(color: darkColor),
          ),
        )
      ],
    );
  }
}
