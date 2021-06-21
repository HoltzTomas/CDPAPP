import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class SignInAndSignUpButtons extends StatelessWidget {
  const SignInAndSignUpButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RoundedButton(
        text: "INICIAR SESION",
        press: () {},
      ),
      RoundedButton(
        text: "REGISTRARSE",
        press: () {},
        textColor: primaryColor,
        color: whiteColor,
      ),
    ]);
  }
}
