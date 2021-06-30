import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/PDF/ui/widgets/custom_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String textToUpload = "";
  bool isValidate = true;

  Widget addDataButton(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: TextButton(
          onPressed: () {
            if (textToUpload.isNotEmpty) {
              final FormCloudRepository formCloudRepository =
                  FormCloudRepository();
              formCloudRepository.uploadTransportData(
                dataToUpload:
                    TransportData(text: textToUpload, tipo: widget.tipo),
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

  Widget textField() => TextField(
        onChanged: (value) {
          textToUpload = value;
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.deny(
            RegExp(r'[/\\]'),
          ),
        ],
        decoration: InputDecoration(
            hintText: "Nombre",
            errorText: !isValidate && textToUpload.isEmpty
                ? "Complete el campo"
                : null),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: CustomDialog(
          button: addDataButton(context),
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
        textField(),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
