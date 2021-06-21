import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class SignUpScreenTitle extends StatelessWidget {
  const SignUpScreenTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Registrarse",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: defaultPadding / 2),
        Text(
          "Crea una cuenta ingresando el nombre de tu empresa, un E-Mail y una contraseña",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
