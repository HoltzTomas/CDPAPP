import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class IssuedCdpListItem extends StatelessWidget {
  const IssuedCdpListItem({Key? key, required this.cdp, required this.userFile})
      : super(key: key);

  final CDP cdp;
  final PdfFile userFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Text(
            cdp.cdpName,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
