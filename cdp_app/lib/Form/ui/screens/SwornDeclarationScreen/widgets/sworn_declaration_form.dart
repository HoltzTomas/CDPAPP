import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/widgets/signature_container.dart';
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
            FormTextField(
              dataWeWantReceive: "Acalaracion",
              onChanged: (String value) {
                watch(aclaracionProvider).state = value;
              },
            ),

            ///D.N.I (Second fact of [SwornDeclarationForm])
            FormTextField(
              dataWeWantReceive: "D.N.I",
              onChanged: (String value) {
                watch(dniProvider).state = value;
              },
            ),

            ///Signature (Third fact of [SwornDeclarationForm])
            const SignatureContainer(),
          ],
        ),
      ),
    );
  }
}

