import 'dart:typed_data';

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
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmitirCdpFAB extends StatelessWidget {
  const EmitirCdpFAB({Key? key, required this.selectedFile}) : super(key: key);

  final PdfFile selectedFile;

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc(selectedFile.pdfName)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(child: Text("No hay conexión a internet"));
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  if (snapshot.data!.get('availableCDPs') as double > 0) {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FormScreen(
                          pdfFile: PdfFile(
                              pdfUrl: snapshot.data!.get('pdfUrl') as String,
                              pdfName: snapshot.data!.get('pdfName') as String,
                              availableCDPs:
                                  snapshot.data!.get('availableCDPs') as double,
                              issuedCDPs:
                                  snapshot.data!.get('issuedCDPs') as double,
                              time: snapshot.data!.get('time') as Timestamp),
                        ),
                      ),
                    );
                    context.read(isCdpBeingEdited).state = false;
                    formProvidersToInitialValue(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "No hay cartas de porte disponibles en este archivo",
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Emitir carta de porte",
                  style: TextStyle(color: darkColor),
                ),
              ),
            );
        }
      },
    );
  }

  void formProvidersToInitialValue(BuildContext context) {
    context.read(titularCartaDePorteProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'titularCartaDePorte');
    context.read(intermediarioProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'intermediario');
    context.read(remitenteComercialProvider).state = TransferData(
      nombre: "",
      cuit: "",
      tipo: 'remitenteComercial',
    );
    context.read(corredorCompradorProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'corredorComprador');
    context.read(mercadoATerminoProvider).state = TransferData(
      nombre: "",
      cuit: "",
      tipo: 'mercadoATermino',
    );
    context.read(corredorVendedorProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'corredorComprador');
    context.read(representanteEntregadorProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'representanteEntregador');
    context.read(destinatarioProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'destinatario');
    context.read(destinoProvider).state = TransferData(
      nombre: "",
      cuit: "",
      tipo: 'destino',
    );
    context.read(intermediarioDelFleteProvider).state = TransferData(
      nombre: "",
      cuit: "",
      tipo: 'intermediarioDelFlete',
    );
    context.read(transportistaProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'transportista');
    context.read(choferProvider).state = TransferData(
        nombre: "",
        cuit: "",
        tipo: 'chofer',
        camion: "",
        acoplado: "");

    ///Editing [GrainDataProviders]
    context.read(granoEspecieProvider).state =
        GrainData(text: "", tipo: 'granoEspecie');
    context.read(tipoProvider).state =
        GrainData(text: "", tipo: 'tipo');
    context.read(cosechaProvider).state =
        GrainData(text: "", tipo: 'cosecha');
    context.read(contratoNroProvider).state =
        GrainData(text: "", tipo: 'contratoNro');
    context.read(seraPesadaProvider).state = false;
    context.read(kgsEstimadosProvider).state =
        GrainData(text: "", tipo: 'kgsEstimados');
    context.read(declaracionDeCalidadProvider).state = GrainData(
        tipo: 'declaracionDeCalidad', text: "");
    context.read(pesoBrutoProvider).state =
        GrainData(text: "", tipo: 'pesoBruto');
    context.read(pesoTaraProvider).state =
        GrainData(text: "", tipo: 'pesoTara');
    context.read(pesoNetoProvider).state =
        GrainData(text: "", tipo: 'pesoNeto');
    context.read(observacionesProvider).state =
        GrainData(text: "", tipo: 'observaciones');
    context.read(procedenciaProvider).state = ProcedenciaMercaderia(
      direccion: "",
      provincia: "",
      localidad: "",
      establecimiento: "",
      renspa: "",
    );

    ///Editing [DestinationProviders]
    context.read(destinationProvider).state = Destination(
        direccion: "",
        provincia: "",
        localidad: "");

    ///Editing [TransportDataProviders]
    context.read(camionProvider).state =
        TransportData(text: "", tipo: 'camion');
    context.read(acopladoProvider).state =
        TransportData(text: "", tipo: 'acoplado');
    context.read(kmARecorrerProvider).state =
        TransportData(text: "", tipo: 'kmARecorrer');
    context.read(tarifaDeReferenciaProvider).state = TransportData(
        text: "", tipo: 'tarifaDeReferencia');
    context.read(tarifaProvider).state =
        TransportData(text: "", tipo: 'tarifa');
    context.read(pagadorDelFleteProvider).state =
        TransportData(text: "", tipo: 'pagadorDelFlete');

    ///Editing [SwornDeclarationProviders]
    context.read(aclaracionProvider).state = "";
    context.read(dniProvider).state = "";
    context.read(signatureImageProvider).state = Uint8List(0);
  }
}
