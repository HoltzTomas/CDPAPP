import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tiene cuenta aun?"),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Registarse",
            style: TextStyle(color: darkColor),
          ),
        )
      ],
    );
  }
}
