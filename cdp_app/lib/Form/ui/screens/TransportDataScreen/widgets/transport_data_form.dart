import 'package:cdp_app/Form/providers/transport_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_data_dropdown_menu.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/form_text_field.dart';

class TransportDataForm extends ConsumerWidget {
  const TransportDataForm({Key? key}) : super(key: key);

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
            ///Camion (First fact of [TransportDataForm])
            TransportDataDropdownMenu(
              tipo: "camion",
              text: "Camión",
              providerToChange: camionProvider,
            ),

            ///Acoplado (Second fact of [TransportDataForm])
            TransportDataDropdownMenu(
              tipo: "acoplado",
              text: "Acoplado",
              providerToChange: acopladoProvider,
            ),

            ///Km a Recorrer (Third fact of [TransportDataForm])
            TransportDataDropdownMenu(
              tipo: "Km a Recorrer",
              text: "kmARecorrer",
              providerToChange: kmARecorrerProvider,
            ),

            ///Tarifa de referencia (Fourth fact of [TransportDataForm])
            TransportDataDropdownMenu(
              tipo: "tarifaDeReferencia",
              text: "Tarifa de referencia",
              providerToChange: tarifaDeReferenciaProvider,
            ),

            ///Tarifa (Fifth fact of [TransportDataForm])
            TransportDataDropdownMenu(
              tipo: "tarifa",
              text: "Tarifa",
              providerToChange: tarifaProvider,
            ),

            ///Pagador del flete (Sixth fact of [TransportDataForm])
            TransportDataDropdownMenu(
              tipo: "pagadorDelFlete",
              text: "Pagador del flete",
              providerToChange: pagadorDelFleteProvider,
            )
          ],
        ),
      ),
    );
  }
}
