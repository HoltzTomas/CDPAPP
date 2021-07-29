import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeNameDialog extends StatefulWidget {
  const ChangeNameDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeNameDialog> createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  String newName = "";
  String? errorText;
  String buttonText = "cambiar nombre";
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return CustomDialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Cambiar nombre",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: defaultPadding),
          TextField(
            decoration: InputDecoration(
              hintText: "Nombre",
              errorText: errorText,
            ),
            onChanged: (value) {
              setState(() {
                newName = value;
              });
            },
          )
        ],
      ),
      button: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: () async {
            final connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi) {
              if (newName.isNotEmpty) {
                setState(() {
                  buttonText = "Cargando...";
                  errorText = null;
                });
                currentUser!.updateDisplayName(newName).whenComplete(
                  () {
                    setState(() {
                      buttonText = "Cambiar nombre";
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: primaryColor,
                        content: Text(
                          "Nombre cambiado con éxito",
                        ),
                      ),
                    );
                  },
                );
              } else {
                setState(() {
                  errorText = "Ingresa un nombre";
                });
              }
            } else {
              setState(() {
                  errorText = "No hay conexión a internet";
                });
            }
          },
          child: const Text(
            "Cambiar nombre",
            style: TextStyle(color: darkColor),
          ),
        ),
      ),
    );
  }
}
