import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'getting_signature_dialog.dart';

class SignatureContainer extends ConsumerWidget {
  const SignatureContainer({
    Key? key,
  }) : super(key: key);

  Widget signaturePadOrImage(ScopedReader watch) => Container(
        margin: const EdgeInsets.all(defaultPadding / 2),
        padding: const EdgeInsets.all(10),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(12)),
        child: watch(isSignatureProvided).state
            ? Image.memory(watch(signatureImageProvider).state)
            : const Center(
                child: Text(
                  'Toca aca para firmar',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: darkColor),
                ),
              ),
      );

  Widget subTitle() => const Text(
        "Sera utilizada en la declaracion jurada y en la firma del remitente",
        style: TextStyle(color: darkColor),
      );

  Widget title() => const Text(
        "Firma",
        style: TextStyle(
          color: darkColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(defaultPadding / 2),
          child: Column(
            children: [
              title(),
              const SizedBox(
                height: 5,
              ),
              subTitle(),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return GetSignatureDialog();
              },
            );
          },
          child: signaturePadOrImage(watch),
        )
      ],
    );
  }
}
