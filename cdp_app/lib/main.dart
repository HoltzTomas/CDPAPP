import 'package:cdp_app/Subs/repository/pruchases_repository.dart';
import 'package:cdp_app/splashscreen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await disableLandscapeMode();
}

Future<void> disableLandscapeMode() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) {
      runApp(
        const ProviderScope(
          child: CartAPPorte(),
        ),
      );
    },
  );
}

class CartAPPorte extends StatefulWidget {
  const CartAPPorte({Key? key}) : super(key: key);

  @override
  State<CartAPPorte> createState() => _CartAPPorteState();
}

class _CartAPPorteState extends State<CartAPPorte> {
  @override
  void initState() {
    super.initState();
    final PurchasesRepository purchasesRepository = PurchasesRepository();
    purchasesRepository.setUp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CDP APP',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreenPage(),
    );
  }
}
