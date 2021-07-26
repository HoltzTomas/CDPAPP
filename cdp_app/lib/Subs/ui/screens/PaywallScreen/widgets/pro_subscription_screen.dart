import 'package:cdp_app/Subs/ui/screens/PaywallScreen/widgets/make_purchase_button.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class ProSubscriptionScreen extends StatelessWidget {
  const ProSubscriptionScreen({Key? key, required this.proSubPackage})
      : super(key: key);

  final Package proSubPackage;

  PageViewModel page1(BuildContext context) => PageViewModel(
        reverse: true,
        titleWidget: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: defaultPadding),
              child: const Text(
                "Emite cartas de porte de manera ilimitada",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        bodyWidget: Container(
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(9),
              border: Border.all()),
          child: Image.asset(
            "assets/images/captura pro.jpg",
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
      );

  PageViewModel page2(BuildContext context) => PageViewModel(
        titleWidget: Container(
          margin: const EdgeInsets.only(top: defaultPadding),
          child: const Text(
            "Guarda y reutiliza datos tantas veces como necesites",
            textAlign: TextAlign.center,
          ),
        ),
        bodyWidget: Container(
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(9),
              border: Border.all()),
          child: Image.asset(
            "assets/images/captura pro 2.jpg",
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: IntroductionScreen(
              showDoneButton: false,
              showNextButton: false,
              dotsDecorator: const DotsDecorator(
                activeColor: primaryColor,
                color: darkColor,
              ),
              globalHeader: Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  "CDP APP PRO",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              pages: [page1(context)],
            ),
          ),
          MakePurchaseButton(packageToPurchase: proSubPackage)
        ],
      ),
    );
  }
}
