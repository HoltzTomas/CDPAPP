import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatApi {
  Future<void> setUp() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("aNGNjQXyQJDEDWNUdhiMpQAeMcESCFlU");
  }

  ///Let's user to make a purchase for PRO SUB
  Future<void> makingSubPurchase(
      Package packageToPurchase, BuildContext context) async {
    try {
      final PurchaserInfo purchaserInfo =
          await Purchases.purchasePackage(packageToPurchase);
      final isPro = purchaserInfo.entitlements.all["CDP APP Pro"]!.isActive;
      if (isPro) {
        context.read(isSubActive).state = true;
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: primaryColor,
            behavior: SnackBarBehavior.floating,
            content: Text(
              "La transacción fue cancelada",
            ),
          ),
        );
      }
    }
  }

  ///Check Sub Status
  Future<void> checkSubStatus(BuildContext context) async {
    final PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    if (purchaserInfo.entitlements.active.isNotEmpty) {
      context.read(isSubActive).state = true;
    } else {
      context.read(isSubActive).state = false;
    }
  }
}
