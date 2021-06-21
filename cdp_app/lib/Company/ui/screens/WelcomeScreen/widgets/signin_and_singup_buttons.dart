import 'package:cdp_app/Company/ui/screens/SignInScreen/signin_screen.dart';
import 'package:cdp_app/Company/ui/screens/SignUpScreen/signup_screen.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignInAndSignUpButtons extends StatelessWidget {
  const SignInAndSignUpButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RoundedButton(
        text: "INICIAR SESION",
        press: () {
          Navigator.push(
            context,
            PageTransition(
              child: SignInScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
      ),
      RoundedButton(
        text: "REGISTRARSE",
        press: () {
          Navigator.push(
            context,
            PageTransition(
              child: SignUpScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        textColor: primaryColor,
        color: whiteColor,
      ),
    ]);
  }
}
