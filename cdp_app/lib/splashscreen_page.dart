import 'package:cdp_app/Company/ui/screens/sign_in_handler.dart';
import 'package:cdp_app/constants.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo.png'),
      title: const Text(""),
      navigator: const SignInHandler(),
      logoSize: MediaQuery.of(context).size.height * 0.15,
      loaderColor: primaryColor,
      loadingText: const Text("Cargando..."),
    );
  }
}
