import 'package:cdp_app/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResendEmailButton extends StatelessWidget {
  const ResendEmailButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Container(
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(9)),
      child: TextButton(
        onPressed: () async {
          final connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            auth.currentUser!.sendEmailVerification().whenComplete(
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryColor,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Email reenviado a ${auth.currentUser!.email}',
                      ),
                    ),
                  ),
                );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: primaryColor,
                behavior: SnackBarBehavior.floating,
                content: Text('No hay conexión a internet'),
              ),
            );
          }
        },
        child: const Text(
          "Reenviar email",
          style: TextStyle(color: whiteColor),
        ),
      ),
    );
  }
}
