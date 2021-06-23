import 'package:cdp_app/Form/providers/destination_providers.dart';
import 'package:cdp_app/Form/ui/screens/DestinationScreen/widgets/destination_dropdown_menu.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DestinationForm extends ConsumerWidget {
  const DestinationForm({Key? key}) : super(key: key);

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
            ///Destino (First fact of [DestinationDataForm])
            DestinationDropdownMenu(
              tipo: "destination",
              text: "Destino",
              providerToChange: destinationProvider,
            )
          ],
        ),
      ),
    );
  }
}
