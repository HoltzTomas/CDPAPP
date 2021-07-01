import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddGrainDataDialog extends StatefulWidget {
  final String? tipo;
  final String? text;

  const AddGrainDataDialog({Key? key, @required this.tipo, @required this.text})
      : super(key: key);

  @override
  _AddGrainDataDialogState createState() => _AddGrainDataDialogState();
}

class _AddGrainDataDialogState extends State<AddGrainDataDialog> {
  String textToUpload = "";
  bool isValidate = true;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Agregar ${widget.text}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextField(
          onChanged: (value) {
            textToUpload = value;
          },
          maxLength: widget.tipo == "cosecha" ? 9 : 12,
          decoration: InputDecoration(
            hintText: hintText(),
            errorText: !isValidate && textToUpload.isEmpty
                ? "Completa el campo"
                : null,
            helperText: widget.tipo == "cosecha" ? "Ejemplo: 2020-2021" : "",
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],
        ),
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
          if (textToUpload.isNotEmpty) {
            setState(() {
              isValidate = true;
            });
            final FormCloudRepository formCloudRepository =
                FormCloudRepository();
            formCloudRepository.uploadGrainData(
              dataToUpload: GrainData(
                text: textToUpload,
                tipo: widget.tipo,
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
  }

  String hintText() {
    if (widget.tipo == "cosecha") {
      return "Cosecha";
    } else {
      return "Nombre";
    }
  }
}
