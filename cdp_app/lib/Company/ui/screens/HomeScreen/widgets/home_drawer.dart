import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthRepository authRepository = AuthRepository();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(auth.currentUser!.email!),
            accountName: Text(auth.currentUser!.displayName!),
            currentAccountPicture: SvgPicture.asset(
              "assets/icons/iconoAgricultor.svg",
              color: Colors.grey,
            ),
            decoration: const BoxDecoration(color: primaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text("Importar cartas de porte"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar Sesion"),
            onTap: () {
              authRepository.signOut();
            },
          ),
        ],
      ),
    );
  }
}
