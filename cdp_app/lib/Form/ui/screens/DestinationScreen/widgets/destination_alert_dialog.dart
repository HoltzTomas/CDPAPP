import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DestinationAlertDialog extends StatefulWidget {
  final String? tipo;
  final String? text;

  const DestinationAlertDialog(
      {Key? key, @required this.tipo, @required this.text})
      : super(key: key);

  @override
  _AddAlertDialogState createState() => _AddAlertDialogState();
}

class _AddAlertDialogState extends State<DestinationAlertDialog> {
  String direccionToUpload = "";
  String provinciaToUpload = "";
  String localidadToUpload = "";

  Widget textFields() => Column(
        children: [
          TextField(
            onChanged: (value) {
              direccionToUpload = value;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
            ],
            decoration: const InputDecoration(hintText: "Direccion"),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextField(
            onChanged: (value) {
              provinciaToUpload = value;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
            ],
            decoration: const InputDecoration(hintText: "Provincia"),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextField(
              onChanged: (value) {
                localidadToUpload = value;
              },
              decoration: const InputDecoration(hintText: "Localidad"),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
              ]),
          const SizedBox(height: defaultPadding / 2),
        ],
      );

  Widget addDestinationButton(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: TextButton(
          onPressed: () {
            final FormCloudRepository formCloudRepository =
                FormCloudRepository();
            formCloudRepository.uploadDestination(
              dataToUpload: Destination(
                direccion: direccionToUpload,
                provincia: provinciaToUpload,
                localidad: localidadToUpload,
              ),
              context: context,
            );
            Navigator.pop(context);
          },
          child: const Text(
            "Agregar",
            style: TextStyle(color: darkColor),
          ),
        ),
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
            textFields(),
            const SizedBox(height: defaultPadding),
            addDestinationButton(context),
          ],
        ),
      ),
    );
  }
}
