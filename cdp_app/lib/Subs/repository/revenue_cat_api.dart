import 'package:cdp_app/Subs/providers/purchases_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatApi {
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
        print(e);
      }
    }
  }
}
