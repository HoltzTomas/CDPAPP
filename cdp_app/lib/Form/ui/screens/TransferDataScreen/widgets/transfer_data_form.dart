import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_dropdown_menu.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferDataForm extends ConsumerWidget {
  const TransferDataForm({Key? key}) : super(key: key);

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
            ///Intermediario (Second fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'intermediario',
              text: "Intermediario",
              providerToChange: intermediarioProvider,
            ),

            ///Remitente Comercial (Third fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'remitenteComercial',
              text: "Remitente comercial",
              providerToChange: remitenteComercialProvider,
            ),

            ///Corredor comprador (Fourth fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'corredorComprador',
              text: "Corredor Cmprador",
              providerToChange: corredorCompradorProvider,
            ),

            ///Mercado a Termino (Fifth fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'mercadoATermino',
              text: "Mercado a Termino",
              providerToChange: mercadoATerminoProvider,
            ),

            ///Corredor vendedor (Sixth fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'corredorVendedor',
              text: "Corredor Vendedor",
              providerToChange: corredorVendedorProvider,
            ),

            ///Representante / Entregador (Seventh fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'representanteEntregador',
              text: "Representante Entregador",
              providerToChange: representanteEntregadorProvider,
            ),

            ///Destinatario (Eight fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'destinatario',
              text: "Destinatario",
              providerToChange: destinatarioProvider,
            ),

            ///Destino (Nineth fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'destino',
              text: "Destino",
              providerToChange: destinoProvider,
            ),

            ///Intermediario del flete (Tenth fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'intermediarioDelFlete',
              text: "Intermediario del Flete",
              providerToChange: intermediarioDelFleteProvider,
            ),

            ///Transportista (Eleventh fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'transportista',
              text: "Transportista",
              providerToChange: transportistaProvider,
            ),

            ///Chofer (Eleventh fact of [TransferData])
            TransferDataDropdownMenu(
              tipo: 'chofer',
              text: "Chofer",
              providerToChange: choferProvider,
            ),
          ],
        ),
      ),
    );
  }
}
