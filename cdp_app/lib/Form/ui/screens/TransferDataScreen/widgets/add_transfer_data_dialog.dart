import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransferDataDialog extends StatefulWidget {
  final String? tipo;
  final String? text;

  const AddTransferDataDialog(
      {Key? key, @required this.tipo, @required this.text})
      : super(key: key);

  @override
  _AddTransferDataDialogState createState() => _AddTransferDataDialogState();
}

class _AddTransferDataDialogState extends State<AddTransferDataDialog> {
  String nombreToUpload = "";
  String cuitToUpload = "";
  String camionToUpload = "";
  String acopladoToUpload = "";

  Widget textFields() {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            nombreToUpload = value;
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          decoration: const InputDecoration(hintText: "Nombre"),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextField(
          onChanged: (value) {
            cuitToUpload = value;
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Cuit"),
        ),
        const SizedBox(height: defaultPadding / 2),
        if (widget.tipo == "chofer")
          TextField(
            onChanged: (value) {
              camionToUpload = value;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
            ],
            decoration: const InputDecoration(hintText: "Camion"),
          ),
        if (widget.tipo == "chofer") const SizedBox(height: defaultPadding / 2),
        if (widget.tipo == "chofer")
          TextField(
            onChanged: (value) {
              acopladoToUpload = value;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
            ],
            decoration: const InputDecoration(hintText: "Acoplado"),
          ),
      ],
    );
  }

  Widget addDataTextButton() => Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: TextButton(
          onPressed: () {
            final FormCloudRepository formCloudRepository =
                FormCloudRepository();
            formCloudRepository.uploadTransferData(
              dataToUpload: TransferData(
                  nombre: nombreToUpload,
                  cuit: cuitToUpload,
                  camion: camionToUpload,
                  acoplado: acopladoToUpload,
                  tipo: widget.tipo),
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
      title: Text(
        "Agregar ${widget.text}",
        style: const TextStyle(color: primaryColor),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            textFields(),
            const SizedBox(height: defaultPadding),
            addDataTextButton()
          ],
        ),
      ),
    );
  }
}
