import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/widgets/signature_container.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/widgets/sworn_data_dropdown_menu.dart';
import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwornDeclarationForm extends ConsumerWidget {
  const SwornDeclarationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///Aclaracion (First fact of [SwornDeclarationForm])
            SwornDataDropdownMenu(
              tipo: "aclaracion",
              text: "Aclaración",
              providerToChange: aclaracionProvider
            ),

            ///D.N.I (Second fact of [SwornDeclarationForm])
            SwornDataDropdownMenu(
              tipo: "dni",
              text: "D.N.I",
              providerToChange: dniProvider
            ),
          ],
        ),
      ),
    );
  }
}
