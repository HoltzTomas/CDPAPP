import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/pdf_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UploadedFileItem extends StatelessWidget {
  const UploadedFileItem({Key? key, required this.userFile}) : super(key: key);

  final PdfFile userFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: PdfScreen(userFile: userFile),
              type: PageTransitionType.rightToLeft),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(userFile.pdfName),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: PdfScreen(userFile: userFile),
                    type: PageTransitionType.rightToLeft),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
