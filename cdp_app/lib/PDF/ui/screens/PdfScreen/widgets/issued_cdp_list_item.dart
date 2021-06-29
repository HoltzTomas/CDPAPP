import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/CDP/repository/cdp_api.dart';
import 'package:cdp_app/CDP/repository/cdp_cloud_repository.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/sworn_declaration_screen.dart';
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
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
                Expanded(child: editCdpButton(context)),
                Expanded(child: copyCdpButton(context)),
                Expanded(child: viewCdpButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Let's the user edits this CDP's data
  Widget editCdpButton(BuildContext context) {
    return 
        IconButton(
          onPressed: () {
            context.read(isCdpBeingEdited).state = true;
            context.read(cdpToEditsName).state = widget.cdp.cdpName;
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: FormScreen(
                  pdfFile: widget.userFile,
                ),
              ),
            );
          },
          icon: const Icon(Icons.edit),
    );
  }

  ///Let's the user copy this CDP's data yo create a new one
  Widget copyCdpButton(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            final CdpApi cdpApi = CdpApi();
            cdpApi.copyCDP(context, pdfFile: widget.userFile, cdp: widget.cdp);
          },
          icon: const Icon(Icons.copy),
        ),
      ],
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
