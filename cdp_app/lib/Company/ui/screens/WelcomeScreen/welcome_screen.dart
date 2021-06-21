import 'package:cdp_app/Company/ui/screens/WelcomeScreen/widgets/signin_and_singup_buttons.dart';
import 'package:cdp_app/Company/ui/screens/WelcomeScreen/widgets/welcome_screent_title.dart';
import 'package:cdp_app/Company/ui/widgets/app_logo.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              const AppLogo(),
              const SizedBox(height: defaultPadding),
              const WelcomeScreenTitle(),
              const SizedBox(height: defaultPadding),
              const SignInAndSignUpButtons(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
