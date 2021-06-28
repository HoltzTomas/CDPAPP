import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/CDP/repository/cdp_cloud_repository.dart';
import 'package:cdp_app/Form/providers/destination_providers.dart';
import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/providers/transport_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/widgets/sworn_declaration_form.dart';
import 'package:cdp_app/Form/ui/widgets/edit_cdp_button.dart';
import 'package:cdp_app/Form/ui/widgets/emit_cdp_button.dart';
import 'package:cdp_app/Form/ui/widgets/form_screen_title.dart';
import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> cdpToEditsName = StateProvider<String>((ref) => "");

class SwornDeclarationScreen extends ConsumerWidget {
  ///The PDF needs four different types of data.
  ///TransferData, GrainData, Destination, TransportData and SwornDeclarationData
  ///
  ///Here we will receive TransferData
  SwornDeclarationScreen({Key? key, required this.selectedFile})
      : super(key: key);

  final PdfFile selectedFile;

  final TextEditingController cdpNameController = TextEditingController();

  Widget filesNameTextField() => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: FormTextField(
          dataWeWantReceive: "Nombre de la Carta de Porte",
          controller: cdpNameController,
        ),
      );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FormScreenTitle(text: "5- Declaracion Jurada"),
            const SizedBox(height: defaultPadding),
            const SwornDeclarationForm(),
            const SizedBox(height: defaultPadding),
            if (!watch(isCdpBeingEdited).state) filesNameTextField(),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                const Spacer(),
                if (!watch(isCdpBeingEdited).state)
                  EmitCdpButton(
                      cdpName: cdpNameController.text,
                      selectedFile: selectedFile),
                if (watch(isCdpBeingEdited).state)
                  EditCdpButton(selectedFile: selectedFile),
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
