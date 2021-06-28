import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

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
  bool trueOrFalseToUpload = false;

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
            TextField(
              onChanged: (value) {
                textToUpload = value;
              },
              maxLength: widget.tipo == "cosecha" ? 10 : null,
              decoration: InputDecoration(
                hintText: hintText(),
                helperText: widget.tipo == "cosecha" ? "Ejemplo: 2020-2021" : "",
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: TextButton(
                onPressed: () {
                  final FormCloudRepository formCloudRepository =
                      FormCloudRepository();
                  formCloudRepository.uploadGrainData(
                    dataToUpload: GrainData(
                        text: textToUpload,
                        tipo: widget.tipo,
                        trueOrFalse: trueOrFalseToUpload),
                    context: context,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  "Agregar",
                  style: TextStyle(color: darkColor),
                ),
              ),
            ),
          ],
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
