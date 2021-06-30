import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class IconReferencesDialog extends StatefulWidget {
  const IconReferencesDialog({Key? key}) : super(key: key);

  @override
  _IconReferencesDialogState createState() => _IconReferencesDialogState();
}

class _IconReferencesDialogState extends State<IconReferencesDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          "Referencias",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding),
        const Text(
          "Una vez emitida la carta de porte, tienes diferentes opciones",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.edit),
            Text("Editar carta de porte"),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.copy),
            Text("Copiar carta de porte"),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.picture_as_pdf),
            Text("Visualizar carta de porte"),
          ],
        )
      ],
    );
  }
}
