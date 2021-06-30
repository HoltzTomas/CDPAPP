import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/repository/cdp_cloud_repository.dart';
import 'package:cdp_app/Form/providers/destination_providers.dart';
import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/Form/providers/transport_data_providers.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmitCdpButton extends StatelessWidget {
  const EmitCdpButton(
      {Key? key, required this.cdpName, required this.selectedFile})
      : super(key: key);

  final String cdpName;
  final PdfFile selectedFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: TextButton(
        onPressed: () {
          if (cdpName.isNotEmpty) {
            final CdpCloudRepository cdpCloudRepository = CdpCloudRepository();
            cdpCloudRepository.emitCDP(
              context: context,
              file: selectedFile,
              cdpName: cdpName,
              cdpData: CDP(
                  numOfEmitionInsideTheFile: (selectedFile.issuedCDPs).round(),
                  cdpName: cdpName,
                  titularCartaDePorte:
                      context.read(titularCartaDePorteProvider).state,
                  intermediario: context.read(intermediarioProvider).state,
                  remitenteComercial:
                      context.read(remitenteComercialProvider).state,
                  corredorComprador:
                      context.read(corredorCompradorProvider).state,
                  mercadoATermino: context.read(mercadoATerminoProvider).state,
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
                  pagadorDelFlete: context.read(pagadorDelFleteProvider).state,
                  aclarcion: context.read(aclaracionProvider).state,
                  dni: context.read(dniProvider).state,
                  signatureImage: context.read(signatureImageProvider).state),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('La carta de porte fue emitida con exito'),
              ),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ponle un nombre a la Carta de Porte'),
              ),
            );
          }
        },
        child: const Text(
          "Emitir Carta de Porte",
          style: TextStyle(color: darkColor),
        ),
      ),
    );
  }
}
