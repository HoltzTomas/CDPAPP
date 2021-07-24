import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/Subs/repository/pruchases_repository.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class MakePurchaseButton extends StatefulWidget {
  const MakePurchaseButton({
    Key? key,
    required this.packageToPurchase,
  }) : super(key: key);

  final Package packageToPurchase;

  @override
  State<MakePurchaseButton> createState() => _MakePurchaseButtonState();
}

class _MakePurchaseButtonState extends State<MakePurchaseButton> {
  String buttonText = "Acceder por USD\$3 al mes";

  @override
  Widget build(BuildContext context) {
    final PurchasesRepository purchasesRepository = PurchasesRepository();
    return RoundedButton(
      text: buttonText,
      press: () async {
        purchasesRepository.makingSubPurchase(widget.packageToPurchase, context);
      },
    );
  }
}
