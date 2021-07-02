import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class EmailVerifiedDialog extends StatelessWidget {
  const EmailVerifiedDialog({Key? key}) : super(key: key);

  Widget contentBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "¡Email verificado con éxito!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomDialog(
        child: contentBox(),
      ),
    );
  }
}
