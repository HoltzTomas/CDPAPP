import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/Company/ui/screens/SignUpScreen/widgets/signin_text.dart';
import 'package:cdp_app/Company/ui/screens/SignUpScreen/widgets/signup_screen_title.dart';
import 'package:cdp_app/Company/ui/widgets/app_logo.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_input_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isLoading = false;

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
                const AppLogo(),
                const SizedBox(height: defaultPadding),
                const SignUpScreenTitle(),
                const SizedBox(height: defaultPadding),
                RoundedInputField(
                  hintText: "Nombre de la empresa",
                  icon: Icons.business_sharp,
                  controller: nameController,
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
                RoundedButton(
                  text: isLoading ? "CARGANDO..." : "REGISTRARSE",
                  press: () {
                    if (emailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty &&
                        nameController.text.trim().isNotEmpty) {
                      setState(
                        () {
                          isLoading = true;
                        },
                      );
                      FirebaseFirestore.instance.terminate();
                      FirebaseFirestore.instance
                          .clearPersistence()
                          .then((value) => authRepository
                                  .signUpWithEmailAndPassword(
                                context: context,
                                name: nameController.text,
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              )
                                  .whenComplete(
                                () {
                                  setState(
                                    () {
                                      isLoading = false;
                                    },
                                  );
                                },
                              ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Complete todos los campos')));
                    }
                  },
                ),
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
