import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class SignInText extends StatelessWidget {
  const SignInText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Ya tiene una cuenta?"),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Inicie sesion",
            style: TextStyle(color: darkColor),
          ),
        )
      ],
    );
  }
}
