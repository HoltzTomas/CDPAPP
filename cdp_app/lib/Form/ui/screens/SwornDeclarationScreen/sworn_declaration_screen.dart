import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/widgets/sworn_declaration_form.dart';
import 'package:cdp_app/Form/ui/widgets/form_screen_title.dart';
import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwornDeclarationScreen extends StatefulWidget {
  ///The PDF needs four different types of data.
  ///TransferData, GrainData, Destination, TransportData and SwornDeclarationData
  ///
  ///Here we will receive TransferData
  const SwornDeclarationScreen({Key? key}) : super(key: key);

  @override
  _SwornDeclarationScreenState createState() => _SwornDeclarationScreenState();
}

class _SwornDeclarationScreenState extends State<SwornDeclarationScreen> {
  final TextEditingController fileNameController = TextEditingController();

  Widget filesNameTextField() => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: FormTextField(
          dataWeWantReceive: "Nombre de la Carta de Porte",
          controller: fileNameController,
        ),
      );

  Widget previewButton() => Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(9),
        ),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            "Vista Previa",
            style: TextStyle(color: darkColor),
          ),
        ),
      );

  Widget emitCDPButton() => Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(9)),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            "Emitir Carta de Porte",
            style: TextStyle(color: darkColor),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FormScreenTitle(text: "5- Declaracion Jurada"),
            const SizedBox(height: defaultPadding),
            const SwornDeclarationForm(),
            const SizedBox(height: defaultPadding),
            filesNameTextField(),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                const Spacer(),
                emitCDPButton(),
                const Spacer(),
                previewButton(),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding)
          ],
        ),
      ),
    );
  }
}
