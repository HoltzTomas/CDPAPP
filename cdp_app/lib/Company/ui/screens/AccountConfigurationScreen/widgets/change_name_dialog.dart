import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
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
          FormTextField(
            dataWeWantReceive: "Nuevo nombre",
            onChanged: (value) {
              setState(() {
                newName = value;
              });
            },
          ),
        ],
      ),
      button: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              buttonText = "Cargando...";
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
