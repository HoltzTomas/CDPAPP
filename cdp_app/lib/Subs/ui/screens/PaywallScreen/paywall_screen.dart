import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:cdp_app/Subs/ui/screens/PaywallScreen/widgets/description_texts.dart';
import 'package:cdp_app/Subs/ui/screens/PaywallScreen/widgets/logo_and_title.dart';
import 'package:cdp_app/Subs/ui/screens/PaywallScreen/widgets/make_purchase_button.dart';
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
                  button: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Volver"),
                  ),
                  child: const Text("SubInfo es null"),
                );
              }
              return Column(
                children: [
                  const Expanded(
                    flex: 2,
                    child: LogoAndTitle(),
                  ),
                  const Expanded(
                    child: DescriptionTexts(),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    child: MakePurchaseButton(packageToPurchase: subInfo),
                  ),
                  const Spacer(),
                ],
              );
            },
            loading: () {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
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
