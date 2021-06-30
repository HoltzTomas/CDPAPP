import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
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
  bool isValidate = true;

  Widget textFields() => Column(
        children: [
          TextField(
            onChanged: (value) {
              direccionToUpload = value;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
            ],
            decoration: InputDecoration(
                hintText: "Direccion",
                errorText:
                    !isValidate && direccionToUpload.isEmpty ? "Complete la direccion" : null),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextField(
            onChanged: (value) {
              provinciaToUpload = value;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
            ],
            decoration: InputDecoration(
                hintText: "Provincia",
                errorText:
                    !isValidate && provinciaToUpload.isEmpty ? "Complete la provincia" : null),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextField(
              onChanged: (value) {
                localidadToUpload = value;
              },
              decoration: InputDecoration(
                  hintText: "Localidad",
                  errorText: !isValidate && localidadToUpload.isEmpty
                      ? "Complete la localidad"
                      : null),
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
            if (direccionToUpload.isNotEmpty &&
                localidadToUpload.isNotEmpty &&
                provinciaToUpload.isNotEmpty) {
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
            } else {
              setState(() {
                isValidate = false;
              });
            }
          },
          child: const Text(
            "Agregar",
            style: TextStyle(color: darkColor),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
            child: CustomDialog(
          button: addDestinationButton(context),
          child: boxContent(context),
        ),
      ),
    );
  }

  Widget boxContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Agregar ${widget.text}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding),
        textFields(),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
