import 'package:cdp_app/Company/ui/screens/AccountConfigurationScreen/widgets/change_name_dialog.dart';
import 'package:cdp_app/Company/ui/screens/ChangePasswordScreen/change_password_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AccountConfigurationScreen extends StatelessWidget {
  const AccountConfigurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Cuenta"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: [
          changeCompanyNameTile(context),
          changeCompanyPasswordTile(context)
        ],
      ),
    );
  }

  Widget changeCompanyNameTile(BuildContext context) => ListTile(
        title: const Text("Nombre de la empresa"),
        subtitle: Text(FirebaseAuth.instance.currentUser!.displayName!),
        trailing: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const ChangeNameDialog();
              },
            );
          },
          child: Text(
            "Cambiar nombre",
            style: TextStyle(
              color: primaryColor.withOpacity(0.9),
            ),
          ),
        ),
      );

  Widget changeCompanyPasswordTile(BuildContext context) => ListTile(
        title: const Text("Contraseña"),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  child: const ChangePasswordScreen(),
                  type: PageTransitionType.bottomToTop),
            );
          },
          child: Text(
            "Cambiar contraseña",
            style: TextStyle(
              color: primaryColor.withOpacity(0.9),
            ),
          ),
        ),
      );
}

