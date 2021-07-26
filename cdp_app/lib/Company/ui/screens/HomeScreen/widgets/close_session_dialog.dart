import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class CloseSesionDialog extends StatefulWidget {
  const CloseSesionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CloseSesionDialog> createState() => _CloseSesionDialogDialogState();
}

class _CloseSesionDialogDialogState extends State<CloseSesionDialog> {
  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepository();
    return CustomDialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "¿Seguro quieres cerrar sesión?",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: defaultPadding),
          RoundedButton(
            text: "Cerrar Sesión",
            press: () {
              authRepository.signOut(context).whenComplete(() => Navigator.pop(context));
            },
          ),
        ],
      ),
    );
  }
}
