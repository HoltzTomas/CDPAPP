import 'package:cdp_app/Company/ui/screens/SignUpScreen/widgets/signin_text.dart';
import 'package:cdp_app/Company/ui/screens/SignUpScreen/widgets/signup_screen_title.dart';
import 'package:cdp_app/Company/ui/widgets/app_logo.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_input_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            width: double.infinity,
            child: Column(
              children: [
                AppLogo(),
                const SizedBox(height: defaultPadding),
                const SignUpScreenTitle(),
                const SizedBox(height: defaultPadding),
                RoundedInputField(
                  hintText: "Nombre de la empresa",
                  icon: Icons.email,
                  controller: emailController,
                ),
                RoundedInputField(
                  hintText: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),
                RoundedInputField(
                  hintText: "Contraseña",
                  icon: Icons.lock,
                  controller: passwordController,
                ),
                RoundedButton(text: "INICIAR SESION", press: () {}),
                const Divider(thickness: 3),
                const SignInText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}