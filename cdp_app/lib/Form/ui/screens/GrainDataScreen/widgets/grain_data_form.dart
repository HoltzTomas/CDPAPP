import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_dropdown_menu.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_dropdown_menu.dart';
import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrainDataForm extends ConsumerWidget {
  const GrainDataForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///Grano/Especie (First fact of [GrainDataForm])
            // TODO: COMPLETE THE CONST LIST
            GrainDataDropdownMenu(
              tipo: 'granoEspecie',
              text: "Grano/Especie",
              providerToChange: granoEspecieProvider,
            ),

            ///Tipo (Second fact of [GrainDataForm])
            GrainDataDropdownMenu(
              tipo: 'tipo',
              text: "Tipo",
              providerToChange: tipoProvider,
            ),

            ///Cosecha (Third fact of [GrainDataForm])
            // TODO: USE DATE SELECTOR OR LIST
            GrainDataDropdownMenu(
              tipo: 'cosecha',
              text: "Cosecha",
              providerToChange: cosechaProvider,
            ),

            ///Contrato Nro (Fourth fact of [GrainDataForm])
            FormTextField(
              dataWeWantReceive: "Contrato Nro",
              keyboardType: TextInputType.text,
              onChanged: (value) {
                watch(contratoNroProvider).state.text = value;
              },
            ),

            ///Sera Pesada en destino (Fifth fact of [GrainDataForm])
            /*GrainDataSwitchButton(
              dataWeWantReceive: "Sera pesada en destino",
              onChanged: (bool value) {
                context.read(seraPesadaProvider).state = value;
              },
              providerToChange: seraPesadaProvider,
            ),*/

            ///Kgs Estimados (Sixth fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == true)
              FormTextField(
                dataWeWantReceive: "Kgs Estimados",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  watch(kgsEstimadosProvider).state = value;
                },
              ),

            ///Declaracion de Calidad (Sixth fact of [GrainDataForm])
            GrainDataDropdownMenu(
              tipo: 'declaracionDeCalidad',
              text: "Declaracion de calidad",
              providerToChange: declaracionDeCalidadProvider,
            ),

            ///Peso Bruto (Seventh fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == false)
              FormTextField(
                dataWeWantReceive: "Peso Bruto",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  watch(pesoBrutoProvider).state.text = value;
                },
              ),

            ///Peso Tara (Eight fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == false)
              FormTextField(
                dataWeWantReceive: "Peso Tara",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  watch(pesoTaraProvider).state.text = value;
                },
              ),

            ///Peso Neto (Nineth fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == false)
              FormTextField(
                dataWeWantReceive: "Peso Neto",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  watch(pesoNetoProvider).state.text = value;
                },
              ),

            ///Observaciones (Tenth fact of [GrainDataForm])
            FormTextField(
              dataWeWantReceive: "Observaciones",
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                watch(observacionesProvider).state.text = value;
              },
            ),

            ///Procedencia de la Mercaderia (Eleventh fact of [GrainDataForm])
            // TODO
            GrainDataDropdownMenu(
              tipo: 'procedenciaMercaderia',
              text: "Procedencia de la Mercaderia",
              procedenciaProviderToChange: procedenciaProvider,
            ),

          ],
        ),
      ),
    );
  }
}
