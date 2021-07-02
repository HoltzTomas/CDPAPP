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
      color: whiteColor,
      child: TextButton(
        onPressed: () async {
          final connectivityResult =
              await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            auth.currentUser!.sendEmailVerification().whenComplete(() =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Email reenviado a ${auth.currentUser!.email}'))));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No hay conexión a internet'),
              ),
            );
          }
        },
        child: const Text(
          "Reenviar email",
          style: TextStyle(color: darkColor),
        ),
      ),
    );
  }
}
