import 'package:cdp_app/Company/ui/screens/AccountConfigurationScreen/account_configuration_screen.dart';
import 'package:cdp_app/Company/ui/screens/ContactScreen/contact_screen.dart';
import 'package:cdp_app/Company/ui/screens/ElectronicCDP/electronic_cdp_screen.dart';
import 'package:cdp_app/Company/ui/screens/HomeScreen/widgets/close_session_dialog.dart';
import 'package:cdp_app/Company/ui/screens/HowToUseScreen/how_to_use_screen.dart';
import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:cdp_app/Subs/repository/pruchases_repository.dart';
import 'package:cdp_app/Subs/ui/screens/PaywallScreen/paywall_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(auth.currentUser!.email!),
            accountName: Text(auth.currentUser!.displayName!),
            currentAccountPicture: SvgPicture.asset(
              "assets/icons/iconoTractor.svg",
              color: Colors.white,
            ),
            decoration: const BoxDecoration(color: primaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text("¿Cómo  usar CDP APP?"),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const HowToUseScreen(),
                    type: PageTransitionType.rightToLeft),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text("Carta de porte electronica"),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const ElectronicCDPScreen(),
                    type: PageTransitionType.rightToLeft),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text("Mi cuenta"),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const AccountConfigurationScreen(),
                    type: PageTransitionType.rightToLeft),
              );
            },
          ),
          Consumer(
            builder: (context, watch, child) {
              return ListTile(
                leading: const Icon(Icons.star_border),
                title: Text(watch(isSubActive).state
                    ? "CDP APP PRO (Activa)"
                    : "CDP APP PRO"),
                onTap: () async{
                  final PurchasesRepository purchasesRepositor =
                      PurchasesRepository();
                  purchasesRepositor.checkSubStatus(context);
                  Navigator.push(
                    context,
                    PageTransition(
                        child: const PaywallScreen(),
                        type: PageTransitionType.bottomToTop),
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page_outlined),
            title: const Text("Contacto"),
            onTap: () {
              Navigator.push(
                    context,
                    PageTransition(
                        child: const ContactScreen(),
                        type: PageTransitionType.rightToLeft),
                  );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar sesión"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const CloseSesionDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
