import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmitirCdpFAB extends StatelessWidget {
  const EmitirCdpFAB({Key? key, required this.selectedFile}) : super(key: key);

  final PdfFile selectedFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                child: FormScreen(pdfFile: selectedFile),
                type: PageTransitionType.rightToLeft),
          );
          context.read(isCdpBeingEdited).state = false;
        },
        child: const Text(
          "Emitir carta de porte",
          style: TextStyle(color: darkColor),
        ),
      ),
    );
  }
}
