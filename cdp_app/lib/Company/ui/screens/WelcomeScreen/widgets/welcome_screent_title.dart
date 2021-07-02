import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';


class WelcomeScreenTitle extends StatelessWidget {
  const WelcomeScreenTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Bienvenido a CDP App",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: defaultPadding / 2),
        Text(
          "¡La manera más sencilla de hacer tus cartas de porte!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}