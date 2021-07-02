import 'package:cdp_app/Company/ui/screens/SignUpScreen/signup_screen.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CancelVerificationButton extends StatelessWidget {
  const CancelVerificationButton({
    Key? key,
  }) : super(key: key);

  Widget contentBox(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "¿Seguro que quiere cancelar la creación de su cuenta?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  auth.currentUser!.delete();
                  auth.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'La cuenta ${auth.currentUser!.email} no ha sido creada'),
                    ),
                  );
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const SignUpScreen(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: const Text(
                  "Si",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: darkColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: darkColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => CustomDialog(child: contentBox(context)));
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}
