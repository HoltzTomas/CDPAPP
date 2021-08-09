import 'package:cdp_app/Company/ui/screens/WelcomeScreen/widgets/signin_and_singup_buttons.dart';
import 'package:cdp_app/Company/ui/screens/WelcomeScreen/widgets/welcome_screent_title.dart';
import 'package:cdp_app/Company/ui/widgets/app_logo.dart';
import 'package:cdp_app/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  Future<void> checkVersion() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final newVersion = NewVersion();
      final status = await newVersion.getVersionStatus();
      if (status!.localVersion != status.storeVersion) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          allowDismissal: false,
          dialogText: "Descarga la nueva version antes de continuar",
          dialogTitle: "Actualizacion disponible",
          dismissButtonText: "Despues",
          updateButtonText: "Actualizar",
        );
      }
    }
  }

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
            children: const [
              Spacer(),
              AppLogo(),
              SizedBox(height: defaultPadding),
              WelcomeScreenTitle(),
              SizedBox(height: defaultPadding),
              SignInAndSignUpButtons(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
