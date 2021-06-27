import 'dart:typed_data';

import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/model/transport_data.dart';

class CDP {
  ///CDP is the abreviation of Carta de Porte,
  ///the document that the users needs to emit.
  ///
  ///Each CDP has exactly 4 pages.
  ///
  ///The user gonna upload to firebase files that contain empty CDPs (Probably more than 1).
  ///So CDP has an int called numOfEmitionInsideTheFile,
  ///which gonna help us to take the correct pages.
  ///
  ///Then we are going to use the rest of the data to complete the document.
  CDP({
    required this.cdpName,
    required this.numOfEmitionInsideTheFile,
    required this.titularCartaDePorte,
    required this.intermediario,
    required this.remitenteComercial,
    required this.corredorComprador,
    required this.mercadoATermino,
    required this.corredorVendedor,
    required this.representanteEntregador,
    required this.destinatario,
    required this.destino,
    required this.intermediarioDelFlete,
    required this.transportista,
    required this.chofer,
    required this.granoEspecie,
    required this.tipo,
    required this.cosecha,
    required this.contratoNro,
    required this.seraPesada,
    required this.kgsEstimados,
    required this.declaracionDeCalidad,
    required this.pesoBruto,
    required this.pesoTara,
    required this.pesoNeto,
    required this.observaciones,
    required this.procedenciaMercaderia,
    required this.destination,
    required this.camion,
    required this.acoplado,
    required this.kmARecorrer,
    required this.tarifaDeReferencia,
    required this.tarifa,
    required this.pagadorDelFlete,
    required this.aclarcion,
    required this.dni,
    required this.signatureImage,
  });

  final String cdpName;
  final int numOfEmitionInsideTheFile;

  //TransferData
  final TransferData titularCartaDePorte;
  final TransferData intermediario;
  final TransferData remitenteComercial;
  final TransferData corredorComprador;
  final TransferData mercadoATermino;
  final TransferData corredorVendedor;
  final TransferData representanteEntregador;
  final TransferData destinatario;
  final TransferData destino;
  final TransferData intermediarioDelFlete;
  final TransferData transportista;
  final TransferData chofer;

  //GrainData
  final GrainData granoEspecie;
  final GrainData tipo;
  final GrainData cosecha;
  final GrainData contratoNro;
  final bool seraPesada;
  final GrainData kgsEstimados;
  final GrainData declaracionDeCalidad;
  final GrainData pesoBruto;
  final GrainData pesoTara;
  final GrainData pesoNeto;
  final GrainData observaciones;
  final ProcedenciaMercaderia procedenciaMercaderia;

  //Destination
  final Destination destination;

  //TransportData
  final TransportData camion;
  final TransportData acoplado;
  final TransportData kmARecorrer;
  final TransportData tarifaDeReferencia;
  final TransportData tarifa;
  final TransportData pagadorDelFlete;

  //SwornDeclaration
  final String aclarcion;
  final String dni;
  final Uint8List signatureImage;
}
