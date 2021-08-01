import 'dart:typed_data';

import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/providers/destination_providers.dart';
import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/providers/transport_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/sworn_declaration_screen.dart';
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class EditButton extends StatelessWidget {
  ///Let's the user edits this CDP's data
  const EditButton({Key? key, required this.selectedFile, required this.cdp})
      : super(key: key);

  final PdfFile selectedFile;
  final CDP cdp;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read(isCdpBeingEdited).state = true;
        context.read(cdpToEditsName).state = cdp.cdpName;
        formProvidersToThiCDPValue(context);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: FormScreen(
              pdfFile: selectedFile,
            ),
          ),
        );
      },
      icon: const Icon(Icons.edit),
    );
  }

  void formProvidersToThiCDPValue(BuildContext context) {
    context.read(titularCartaDePorteProvider).state = TransferData(
        nombre: cdp.titularCartaDePorte.nombre,
        cuit: cdp.titularCartaDePorte.cuit,
        tipo: 'titularCartaDePorte');
    context.read(intermediarioProvider).state = TransferData(
        nombre: cdp.intermediario.nombre,
        cuit: cdp.intermediario.cuit,
        tipo: 'intermediario');
    context.read(remitenteComercialProvider).state = TransferData(
      nombre: cdp.remitenteComercial.nombre,
      cuit: cdp.remitenteComercial.cuit,
      tipo: 'remitenteComercial',
    );
    context.read(corredorCompradorProvider).state = TransferData(
        nombre: cdp.corredorComprador.nombre,
        cuit: cdp.corredorComprador.cuit,
        tipo: 'corredorComprador');
    context.read(mercadoATerminoProvider).state = TransferData(
      nombre: cdp.mercadoATermino.nombre,
      cuit: cdp.mercadoATermino.cuit,
      tipo: 'mercadoATermino',
    );
    context.read(corredorVendedorProvider).state = TransferData(
        nombre: cdp.corredorComprador.nombre,
        cuit: cdp.corredorComprador.cuit,
        tipo: 'corredorComprador');
    context.read(representanteEntregadorProvider).state = TransferData(
        nombre: cdp.representanteEntregador.nombre,
        cuit: cdp.representanteEntregador.cuit,
        tipo: 'representanteEntregador');
    context.read(destinatarioProvider).state = TransferData(
        nombre: cdp.destinatario.nombre,
        cuit: cdp.destinatario.cuit,
        tipo: 'destinatario');
    context.read(destinoProvider).state = TransferData(
      nombre: cdp.destino.nombre,
      cuit: cdp.destino.cuit,
      tipo: 'destino',
    );
    context.read(intermediarioDelFleteProvider).state = TransferData(
      nombre: cdp.intermediarioDelFlete.nombre,
      cuit: cdp.intermediarioDelFlete.cuit,
      tipo: 'intermediarioDelFlete',
    );
    context.read(transportistaProvider).state = TransferData(
        nombre: cdp.transportista.nombre,
        cuit: cdp.transportista.cuit,
        tipo: 'transportista');
    context.read(choferProvider).state = TransferData(
        nombre: cdp.chofer.nombre,
        cuit: cdp.chofer.cuit,
        tipo: 'chofer',
        camion: cdp.chofer.camion,
        acoplado: cdp.chofer.acoplado);

    ///Copying [GrainDataProviders]
    context.read(granoEspecieProvider).state =
        GrainData(text: cdp.granoEspecie.text, tipo: 'granoEspecie');
    context.read(tipoProvider).state =
        GrainData(text: cdp.tipo.text, tipo: 'tipo');
    context.read(cosechaProvider).state =
        GrainData(text: cdp.cosecha.text, tipo: 'cosecha');
    context.read(contratoNroProvider).state =
        GrainData(text: cdp.contratoNro.text, tipo: 'contratoNro');
    context.read(seraPesadaProvider).state = cdp.seraPesada;
    context.read(kgsEstimadosProvider).state =
        GrainData(text: cdp.kgsEstimados.text, tipo: 'kgsEstimados');
    context.read(declaracionDeCalidadProvider).state = GrainData(
        tipo: 'declaracionDeCalidad', text: cdp.declaracionDeCalidad.text);
    context.read(pesoBrutoProvider).state =
        GrainData(text: cdp.pesoBruto.text, tipo: 'pesoBruto');
    context.read(pesoTaraProvider).state =
        GrainData(text: cdp.pesoTara.text, tipo: 'pesoTara');
    context.read(pesoNetoProvider).state =
        GrainData(text: cdp.pesoNeto.text, tipo: 'pesoNeto');
    context.read(observacionesProvider).state =
        GrainData(text: cdp.observaciones.text, tipo: 'observaciones');
    context.read(procedenciaProvider).state = ProcedenciaMercaderia(
      direccion: cdp.procedenciaMercaderia.direccion,
      provincia: cdp.procedenciaMercaderia.provincia,
      localidad: cdp.procedenciaMercaderia.localidad,
      establecimiento: cdp.procedenciaMercaderia.establecimiento,
      renspa: cdp.procedenciaMercaderia.renspa,
    );

    ///Copying [DestinationProviders]
    context.read(destinationProvider).state = Destination(
        direccion: cdp.destination.direccion,
        provincia: cdp.destination.provincia,
        localidad: cdp.destination.localidad);

    ///Copying [TransportDataProviders]
    context.read(camionProvider).state =
        TransportData(text: cdp.camion.text, tipo: 'camion');
    context.read(acopladoProvider).state =
        TransportData(text: cdp.acoplado.text, tipo: 'acoplado');
    context.read(kmARecorrerProvider).state =
        TransportData(text: cdp.kmARecorrer.text, tipo: 'kmARecorrer');
    context.read(tarifaDeReferenciaProvider).state = TransportData(
        text: cdp.tarifaDeReferencia.text, tipo: 'tarifaDeReferencia');
    context.read(tarifaProvider).state =
        TransportData(text: cdp.tarifa.text, tipo: 'tarifa');
    context.read(pagadorDelFleteProvider).state =
        TransportData(text: cdp.pagadorDelFlete.text, tipo: 'pagadorDelFlete');

    ///Copying [SwornDeclarationProviders]
    context.read(aclaracionProvider).state = cdp.aclarcion;
    context.read(dniProvider).state = cdp.dni;
  }
}
