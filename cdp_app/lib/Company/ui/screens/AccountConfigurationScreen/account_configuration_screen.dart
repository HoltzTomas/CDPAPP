import 'package:cdp_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          changeCompanyNameTile(),
          changeCompanyPasswordTile()
        ],
      ),
    );
  }

  Widget changeCompanyNameTile() => ListTile(
        title: const Text("Nombre de la empresa"),
        subtitle: Text(FirebaseAuth.instance.currentUser!.displayName!),
        trailing: TextButton(
          onPressed: () {},
          child: Text(
            "Cambiar nombre",
            style: TextStyle(
              color: primaryColor.withOpacity(0.9),
            ),
          ),
        ),
      );

  Widget changeCompanyPasswordTile() => ListTile(
        title: const Text("Contraseña"),
        trailing: TextButton(
          onPressed: () {},
          child: Text(
            "Cambiar contraseña",
            style: TextStyle(
              color: primaryColor.withOpacity(0.9),
            ),
          ),
        ),
      );
}
