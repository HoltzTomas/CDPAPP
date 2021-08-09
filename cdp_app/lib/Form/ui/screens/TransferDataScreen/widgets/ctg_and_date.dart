import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_data_dropdown_menu.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

import 'date_dropdown_menu.dart';

class CGTAndDate extends StatelessWidget {
  const CGTAndDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, top: defaultPadding),
      child: Column(
        children: [
          TransportDataDropdownMenu(
              text: "CGT", providerToChange: ctgProvider, tipo: "ctg"),
          const DateDropdownMenu()
        ],
      ),
    );
  }
}