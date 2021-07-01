import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleAndSubTitle(),
              const SizedBox(height: defaultPadding),
              Row(
                children: [emailTextField(), sendEmailButton(context)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Expanded(
      flex: 2,
      child: FormTextField(
        dataWeWantReceive: "Email",
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget sendEmailButton(BuildContext context) {
    return Expanded(
      child: Container(
        color: primaryColor,
        child: TextButton(
          onPressed: () async {
            final FirebaseAuth auth = FirebaseAuth.instance;
            final connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi) {
              auth
                  .sendPasswordResetEmail(email: emailController.text)
                  .whenComplete(
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Email enviado a ${emailController.text}',
                        ),
                      ),
                    ),
                  );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'No hay conneccion a internet',
                  ),
                ),
              );
            }
          },
          child: const Text(
            "Enviar Mail",
            style: TextStyle(color: darkColor),
          ),
        ),
      ),
    );
  }

  Widget titleAndSubTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Cambiar contraseña",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: defaultPadding / 2),
        Text(
          "Ingresa el E-Mail de tu cuenta para que podamos ayudarte a cambiar tu contraseña",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
