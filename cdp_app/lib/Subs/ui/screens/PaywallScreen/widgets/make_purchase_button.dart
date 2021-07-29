import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:cdp_app/Subs/repository/pruchases_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class MakePurchaseButton extends ConsumerWidget {
  const MakePurchaseButton({
    Key? key,
    required this.packageToPurchase,
  }) : super(key: key);

  final Package packageToPurchase;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final PurchasesRepository purchasesRepository = PurchasesRepository();
    return Container(
      child: !watch(isSubActive).state
          ? RoundedButton(
              text: "Acceder por USD\$3 por mes",
              press: () async {
                purchasesRepository.checkSubStatus(context);
                purchasesRepository.makingSubPurchase(
                    packageToPurchase, context);
              },
            )
          : RoundedButton(
              text: "Tu suscripcion esta activa",
              color: Colors.transparent,
              textColor: primaryColor,
              press: () async {},
            ),
    );
  }
}
