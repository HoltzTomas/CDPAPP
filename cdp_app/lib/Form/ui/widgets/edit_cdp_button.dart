import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/providers/cdp_providers.dart';
import 'package:cdp_app/CDP/repository/cdp_cloud_repository.dart';
import 'package:cdp_app/Form/providers/destination_providers.dart';
import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/providers/transport_data_providers.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/sworn_declaration_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCdpButton extends StatelessWidget {
  const EditCdpButton({Key? key, required this.selectedFile}) : super(key: key);

  final PdfFile selectedFile;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextButton(
            onPressed: () async {
              final CdpCloudRepository cdpCloudRepository =
                  CdpCloudRepository();
              cdpCloudRepository.editCDP(
                context: context,
                file: selectedFile,
                cdpData: CDP(
                    numOfEmitionInsideTheFile:
                        (selectedFile.issuedCDPs).round(),
                    cdpName: watch(cdpToEditsName).state,
                    titularCartaDePorte:
                        context.read(titularCartaDePorteProvider).state,
                    intermediario: context.read(intermediarioProvider).state,
                    remitenteComercial:
                        context.read(remitenteComercialProvider).state,
                    corredorComprador:
                        context.read(corredorCompradorProvider).state,
                    mercadoATermino:
                        context.read(mercadoATerminoProvider).state,
                    corredorVendedor:
                        context.read(corredorVendedorProvider).state,
                    representanteEntregador:
                        context.read(representanteEntregadorProvider).state,
                    destinatario: context.read(destinatarioProvider).state,
                    destino: context.read(destinoProvider).state,
                    intermediarioDelFlete:
                        context.read(intermediarioDelFleteProvider).state,
                    transportista: context.read(transportistaProvider).state,
                    chofer: context.read(choferProvider).state,
                    granoEspecie: context.read(granoEspecieProvider).state,
                    tipo: context.read(tipoProvider).state,
                    cosecha: context.read(cosechaProvider).state,
                    contratoNro: context.read(contratoNroProvider).state,
                    seraPesada: context.read(seraPesadaProvider).state,
                    kgsEstimados: context.read(kgsEstimadosProvider).state,
                    declaracionDeCalidad:
                        context.read(declaracionDeCalidadProvider).state,
                    pesoBruto: context.read(pesoBrutoProvider).state,
                    pesoTara: context.read(pesoTaraProvider).state,
                    pesoNeto: context.read(pesoNetoProvider).state,
                    observaciones: context.read(observacionesProvider).state,
                    procedenciaMercaderia:
                        context.read(procedenciaProvider).state,
                    destination: context.read(destinationProvider).state,
                    camion: context.read(camionProvider).state,
                    acoplado: context.read(acopladoProvider).state,
                    kmARecorrer: context.read(kmARecorrerProvider).state,
                    tarifaDeReferencia:
                        context.read(tarifaDeReferenciaProvider).state,
                    tarifa: context.read(tarifaProvider).state,
                    pagadorDelFlete:
                        context.read(pagadorDelFleteProvider).state,
                    aclarcion: context.read(aclaracionProvider).state,
                    dni: context.read(dniProvider).state,
                    signatureImage: context.read(signatureImageProvider).state),
              );
              context.read(isCdpBeingEdited).state = false;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('La carta de porte fue editada con exito'),
                ),
              );
              await FirebaseFirestore.instance.clearPersistence();
              Navigator.pop(context);
            },
            child: const Text(
              "Editar Carta de Porte",
              style: TextStyle(color: darkColor),
            ),
          ),
        );
      },
    );
  }
}
