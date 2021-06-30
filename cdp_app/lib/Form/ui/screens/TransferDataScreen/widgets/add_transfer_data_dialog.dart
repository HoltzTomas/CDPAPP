import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
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
  bool isValidate = true;

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
          decoration: InputDecoration(
            hintText: "Nombre",
            errorText: !isValidate && nombreToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
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
          decoration: InputDecoration(
            hintText: "Cuit",
            errorText: !isValidate && cuitToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
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
            decoration: InputDecoration(
              hintText: "Camion",
              errorText: !isValidate && camionToUpload.isEmpty
                  ? "Completa el campo"
                  : null,
            ),
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
            decoration: InputDecoration(
              hintText: "Acoplado",
              errorText: !isValidate && acopladoToUpload.isEmpty
                  ? "Completa el campo"
                  : null,
            ),
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
            if (nombreToUpload.isNotEmpty &&
                cuitToUpload.isNotEmpty &&
                camionToUpload.isNotEmpty &&
                acopladoToUpload.isNotEmpty) {
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
          button: addDataTextButton(),
          child: contentBox(),
        ),
      ),
    );
  }

  Widget contentBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Agregar ${widget.text}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding / 2),
        textFields(),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
