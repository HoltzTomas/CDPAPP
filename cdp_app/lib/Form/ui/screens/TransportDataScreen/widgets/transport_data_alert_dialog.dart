import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class TransportDataAlertDialog extends StatefulWidget {
  final String? tipo;
  final String? text;

  const TransportDataAlertDialog(
      {Key? key, @required this.tipo, @required this.text})
      : super(key: key);

  @override
  _AddAlertDialogState createState() => _AddAlertDialogState();
}

class _AddAlertDialogState extends State<TransportDataAlertDialog> {
  String nameToUpload = "";

  Widget addDataButton(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            "Agregar",
            style: TextStyle(color: darkColor),
          ),
        ),
      );

  Widget textField() => TextField(
        onChanged: (value) {
          nameToUpload = value;
        },
        decoration: const InputDecoration(hintText: "Nombre"),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Agregar ${widget.text}",
          style: const TextStyle(color: primaryColor)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            textField(),
            const SizedBox(height: defaultPadding),
            addDataButton(context),
          ],
        ),
      ),
    );
  }
}
