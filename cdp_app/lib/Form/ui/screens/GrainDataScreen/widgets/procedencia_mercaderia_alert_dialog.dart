import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProcedenciaMercaderiaAlertDialog extends StatefulWidget {
  final String? tipo;
  final String? text;

  const ProcedenciaMercaderiaAlertDialog(
      {Key? key, @required this.tipo, @required this.text})
      : super(key: key);

  @override
  _AddAlertDialogState createState() => _AddAlertDialogState();
}

class _AddAlertDialogState extends State<ProcedenciaMercaderiaAlertDialog> {
  String direccionToUpload = "";
  String provinciaToUpload = "";
  String localidadToUpload = "";
  String establecimientoToUpload = "";
  String renspaToUpload = "";
  bool isValidate = true;
  int maxLength = 25;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: CustomDialog(
          button: addButton(context),
          child: contentBox(context),
        ),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Agregar ${widget.text}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding),
        TextField(
          onChanged: (value) {
            direccionToUpload = value;
          },
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: "Dirección",
            errorText: !isValidate && direccionToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        TextField(
          onChanged: (value) {
            provinciaToUpload = value;
          },
          maxLength: maxLength,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          decoration: InputDecoration(
            hintText: "Provincia",
            errorText: !isValidate && provinciaToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextField(
          onChanged: (value) {
            localidadToUpload = value;
          },
          maxLength:maxLength,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          decoration: InputDecoration(
            hintText: "Localidad",
            errorText: !isValidate && localidadToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextField(
          onChanged: (value) {
            establecimientoToUpload = value;
          },
          maxLength: maxLength,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          decoration: InputDecoration(
            hintText: "Establecimiento",
            errorText: !isValidate && establecimientoToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextField(
          onChanged: (value) {
            renspaToUpload = value;
          },
          maxLength: maxLength,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
          decoration: InputDecoration(
            hintText: "RENSPA",
            errorText: !isValidate && renspaToUpload.isEmpty
                ? "Completa el campo"
                : null,
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
      ],
    );
  }

  Widget addButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextButton(
        onPressed: () {
          if (direccionToUpload.isNotEmpty &&
              localidadToUpload.isNotEmpty &&
              provinciaToUpload.isNotEmpty &&
              establecimientoToUpload.isNotEmpty &&
              renspaToUpload.isNotEmpty) {
            final FormCloudRepository cloudRepository = FormCloudRepository();
            cloudRepository.uploadProcedenciaMercaderia(
              context: context,
              dataToUpload: ProcedenciaMercaderia(
                  direccion: direccionToUpload,
                  provincia: provinciaToUpload,
                  localidad: localidadToUpload,
                  establecimiento: establecimientoToUpload,
                  renspa: renspaToUpload),
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
  }
}
