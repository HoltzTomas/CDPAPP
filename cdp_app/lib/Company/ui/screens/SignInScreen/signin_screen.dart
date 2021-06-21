import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/Company/ui/screens/SignInScreen/widgets/change_password_text.dart';
import 'package:cdp_app/Company/ui/screens/SignInScreen/widgets/signup_text.dart';
import 'package:cdp_app/Company/ui/widgets/app_logo.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_input_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/signin_screen_title.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepository();
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
                const 
                AppLogo(),
                const SizedBox(height: defaultPadding),
                const SignInScreenTitle(),
                const SizedBox(height: defaultPadding),
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
                RoundedButton(
                  text: "INICIAR SESION",
                  press: () {
                    authRepository.signInWithEmailAndPassword(
                      context: context,
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
                ),
                const Divider(thickness: 3),
                const SignUpText(),
                const ChangePasswordText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
