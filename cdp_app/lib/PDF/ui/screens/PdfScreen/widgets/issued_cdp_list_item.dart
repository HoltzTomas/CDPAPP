import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/CDP/repository/cdp_api.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/sworn_declaration_screen.dart';
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/copy_button.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/edit_button.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class IssuedCdpListItem extends StatefulWidget {
  const IssuedCdpListItem({Key? key, required this.cdp, required this.userFile})
      : super(key: key);

  final CDP cdp;
  final PdfFile userFile;

  @override
  _IssuedCdpListItemState createState() => _IssuedCdpListItemState();
}

class _IssuedCdpListItemState extends State<IssuedCdpListItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.cdp.cdpName,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: EditButton(
                    selectedFile: widget.userFile,
                    cdp: widget.cdp,
                  ),
                ),
                Expanded(
                  child: CopyButton(
                    selectedFile: widget.userFile,
                    cdp: widget.cdp,
                  ),
                ),
                Expanded(child: viewCdpButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Let's the user see this CDP's in a PDF
  Widget viewCdpButton() {
    return IconButton(
      onPressed: () {
        final CdpApi cdpApi = CdpApi();
        setState(() {
          isLoading = true;
        });
        cdpApi
            .fillPdfFileWithCdpData(file: widget.userFile, cdp: widget.cdp)
            .whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
      },
      icon: isLoading
          ? const CircularProgressIndicator()
          : const Icon(Icons.picture_as_pdf),
    );
  }
}
