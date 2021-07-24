import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final FutureProvider<Package?> subInformation = FutureProvider(
  (ref) async {
    try {
      final Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        return offerings.current!.monthly!;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  },
);

final StateProvider isSubActive = StateProvider<bool>((ref) => false);
