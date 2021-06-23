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
            FormTextField(
              dataWeWantReceive: "Camion",
              onChanged: (String value) {
                watch(camionProvider).state = value;
              },
            ),

            ///Acoplado (Second fact of [TransportDataForm])
            FormTextField(
              dataWeWantReceive: "Acoplado",
              onChanged: (String value) {
                watch(acopladoProvider).state = value;
              },
            ),

            ///Km a Recorrer (Third fact of [TransportDataForm])
            FormTextField(
              dataWeWantReceive: "Km a Recorrer",
              onChanged: (String value) {
                watch(kmARecorrerProvider).state = value;
              },
            ),

            ///Tarifa de referencia (Fourth fact of [TransportDataForm])
            FormTextField(
              dataWeWantReceive: "Tarifa de Referencia",
              onChanged: (String value) {
                watch(tarifaDeReferenciaProvider).state = value;
              },
            ),

            ///Tarifa (Fifth fact of [TransportDataForm])
            FormTextField(
              dataWeWantReceive: "Tarifa",
              onChanged: (String value) {
                watch(tarifaProvider).state = value;
              },
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
