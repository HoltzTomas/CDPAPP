import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:cdp_app/Subs/ui/screens/PaywallScreen/widgets/pro_subscription_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer(
        builder: (context, watch, child) {
          return watch(subInformation).when(
            data: (subInfo) {
              if (subInfo == null) {
                return CustomDialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Ocurrió un error, revisa tu conexión a internet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: defaultPadding / 2),
                      Text(
                        "De persistir el error, cierre y abra la app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ProSubscriptionScreen(proSubPackage: subInfo);
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (e, st) {
              return CustomDialog(
                button: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Volver"),
                ),
                child: Text("Ocurrio un error $e"),
              );
            },
          );
        },
      ),
    );
  }
}
