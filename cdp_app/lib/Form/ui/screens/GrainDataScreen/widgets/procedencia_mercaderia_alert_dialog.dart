import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

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
            TextField(
              onChanged: (value) {
                direccionToUpload = value;
              },
              decoration: const InputDecoration(hintText: "Direccion"),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextField(
              onChanged: (value) {
                provinciaToUpload = value;
              },
              decoration: const InputDecoration(hintText: "Provincia"),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextField(
              onChanged: (value) {
                localidadToUpload = value;
              },
              decoration: const InputDecoration(hintText: "Localidad"),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextField(
              onChanged: (value) {
                establecimientoToUpload = value;
              },
              decoration: const InputDecoration(hintText: "Establecimiento"),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextField(
              onChanged: (value) {
                renspaToUpload = value;
              },
              decoration: const InputDecoration(hintText: "RENSPA"),
            ),
            const SizedBox(height: defaultPadding),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: TextButton(
                onPressed: () {
                  final FormCloudRepository cloudRepository =
                      FormCloudRepository();
                  cloudRepository.uploadProcedenciaMercaderia(
                    context: context,
                    dataToUpload: ProcedenciaMercaderia(
                      direccion: direccionToUpload,
                      provincia: provinciaToUpload,
                      localidad: localidadToUpload,
                      establecimiento: establecimientoToUpload,
                      renspa: renspaToUpload
                    ),
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
}
