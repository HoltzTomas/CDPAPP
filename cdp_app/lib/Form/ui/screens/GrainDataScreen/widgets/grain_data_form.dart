import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_bottom_sheet_field.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_dropdown_menu.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_switch_button.dart';
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
            GrainDataDropdownMenu(
              tipo: 'cosecha',
              text: "Cosecha",
              providerToChange: cosechaProvider,
            ),

            ///Contrato Nro (Fourth fact of [GrainDataForm])
            GrainDataDropdownMenu(
              text: "Contrato Numero",
              tipo: "contratoNro",
              providerToChange: contratoNroProvider,
            ),

            ///Declaracion de Calidad (Sixth fact of [GrainDataForm])
            GrainDataDropdownMenu(
              tipo: 'declaracionDeCalidad',
              text: "Declaración de calidad",
              providerToChange: declaracionDeCalidadProvider,
            ),

            ///Observaciones (Tenth fact of [GrainDataForm])
            GrainDataDropdownMenu(
                text: "Observaciones",
                tipo: "observaciones",
                providerToChange: observacionesProvider,
              ),

            ///Procedencia de la Mercaderia (Eleventh fact of [GrainDataForm])
            GrainDataDropdownMenu(
              tipo: 'procedenciaMercaderia',
              text: "Procedencia de la Mercaderia",
              procedenciaProviderToChange: procedenciaProvider,
            ),

            ///Sera Pesada en destino (Fifth fact of [GrainDataForm])
            GrainDataSwitchButton(
              dataWeWantReceive: "Será pesada en destino",
              onChanged: (bool value) {
                context.read(seraPesadaProvider).state = value;
              },
              providerToChange: seraPesadaProvider,
            ),

            ///Kgs Estimados (Sixth fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == true)
              GrainDataDropdownMenu(
                text: "Kgs Estimados",
                tipo: "kgsEstimados",
                providerToChange: kgsEstimadosProvider,
              ),

            ///Peso Bruto (Seventh fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == false)
              GrainDataDropdownMenu(
                text: "Peso Bruto",
                tipo: "pesoBruto",
                providerToChange: pesoBrutoProvider,
              ),

            ///Peso Tara (Eight fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == false)
              GrainDataDropdownMenu(
                text: "Peso Tara",
                tipo: "pesoTara",
                providerToChange: pesoTaraProvider,
              ),

            ///Peso Neto (Nineth fact of [GrainDataForm])
            if (watch(seraPesadaProvider).state == false)
              GrainDataDropdownMenu(
                text: "Peso Neto",
                tipo: "pesoNeto",
                providerToChange: pesoNetoProvider,
              ),
          ],
        ),
      ),
    );
  }
}
