import 'dart:typed_data';

import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/repository/cdp_firebase_api.dart';
import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/issued_cdp_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CdpFirebaseApi {
  final FirebaseFirestore firebaseCloud = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  ///When the user emits a [CDP] we are going to upload the data from [FormScreen]
  ///in CloudFirestore.
  ///
  ///Then, the user can use this data in [PdfScreen] to see the PDF.
  Future<void> emitCDP(
      {required PdfFile file,
      required CDP cdpData,
      required String cdpName,
      required BuildContext context}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //First, we upload the number of CDPs that are available in the File
      firebaseCloud
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc(file.pdfName)
          .update(
        {
          'issuedCDPs': file.issuedCDPs + 1,
          'availableCDPs': file.availableCDPs - 1,
        },
      );

      //Then we upload the new CDP's Data in a new Document
      firebaseCloud
          .collection(currentUser!.uid)
          .doc('pdfs')
          .collection('pdfFiles')
          .doc(file.pdfName)
          .collection('emitedCdps')
          .doc(cdpName)
          .set(
        {
          'numOfEmitionInsideTheFile': file.issuedCDPs.round() + 1,
          'cdpName': cdpData.cdpName,
          'nombreTitularCartaDePorte': cdpData.titularCartaDePorte.nombre,
          'cuitTitularCartaDePorte': cdpData.titularCartaDePorte.cuit,
          'nombreIntermediario': cdpData.intermediario.nombre,
          'cuitIntermediario': cdpData.intermediario.cuit,
          'nombreRemitenteComercial': cdpData.remitenteComercial.nombre,
          'cuitRemitenteComercial': cdpData.remitenteComercial.cuit,
          'nombreCorredorComprador': cdpData.corredorComprador.nombre,
          'cuitCorredorComprador': cdpData.corredorComprador.cuit,
          'nombreMercadoATermino': cdpData.mercadoATermino.nombre,
          'cuitMercadoATermino': cdpData.mercadoATermino.cuit,
          'nombreCorredorVendedor': cdpData.corredorVendedor.nombre,
          'cuitCorredorVendedor': cdpData.corredorVendedor.cuit,
          'nombreRepresentanteEntregador':
              cdpData.representanteEntregador.nombre,
          'cuitRepresentanteEntregador': cdpData.representanteEntregador.cuit,
          'nombreDestinatario': cdpData.destinatario.nombre,
          'cuitDestinatario': cdpData.destinatario.cuit,
          'nombreDestino': cdpData.destino.nombre,
          'cuitDestino': cdpData.destino.cuit,
          'nombreIntermediarioDelFlete': cdpData.intermediarioDelFlete.nombre,
          'cuitIntermediarioDelFlete': cdpData.intermediarioDelFlete.cuit,
          'nombreTransportista': cdpData.transportista.nombre,
          'cuitTransportista': cdpData.transportista.cuit,
          'nombreChofer': cdpData.chofer.nombre,
          'cuitChofer': cdpData.chofer.cuit,
          'granoEspecie': cdpData.granoEspecie.text,
          'tipo': cdpData.tipo.text,
          'cosecha': cdpData.cosecha.text,
          'contratoNro': cdpData.contratoNro.text,
          'seraPesada': cdpData.seraPesada,
          'kgsEstimados': cdpData.kgsEstimados,
          'declaracionDeCalidad': cdpData.declaracionDeCalidad.text,
          'pesoBruto': cdpData.pesoBruto.text,
          'pesoTara': cdpData.pesoTara.text,
          'pesoNeto': cdpData.pesoNeto.text,
          'observaciones': cdpData.observaciones.text,
          'direccionProcedenciaMercaderia':
              cdpData.procedenciaMercaderia.direccion,
          'provinciaProcedenciaMercaderia':
              cdpData.procedenciaMercaderia.provincia,
          'localidadProcedenciaMercaderia':
              cdpData.procedenciaMercaderia.localidad,
          'establecimientoProcedenciaMercaderia':
              cdpData.procedenciaMercaderia.establecimiento,
          'renspaProcedenciaMercaderia': cdpData.procedenciaMercaderia.renspa,
          'direccionDestino': cdpData.destination.direccion,
          'provinciaDestino': cdpData.destination.provincia,
          'localidadDestino': cdpData.destination.localidad,
          'camion': cdpData.camion,
          'acoplado': cdpData.acoplado,
          'kmARecorrer': cdpData.kmARecorrer,
          'tarifaDeReferencia': cdpData.tarifaDeReferencia,
          'tarifa': cdpData.tarifa,
          'pagadorDelFlete': cdpData.pagadorDelFlete.text,
          'aclaracion': cdpData.aclarcion,
          'dni': cdpData.tarifa,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay coneccion a internet')));
    }
  }

  ///This method build the CDPs that have been issued, in a single PdfFile,
  ///as [IssuedCDPListItem]
  List<IssuedCdpListItem> buildCDPs(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list,
      required PdfFile userFile}) {
    final List<IssuedCdpListItem> listItems = [];
    for (final cdp in list) {
      listItems.add(
        IssuedCdpListItem(
          userFile: userFile,
          cdp: CDP(
              numOfEmitionInsideTheFile:
                  cdp.get('numOfEmitionInsideTheFile') as int,
              cdpName: cdp.get('cdpName') as String,
              titularCartaDePorte: TransferData(
                  nombre: cdp.get('nombreTitularCartaDePorte') as String,
                  cuit: cdp.get('cuitTitularCartaDePorte') as String),
              intermediario: TransferData(
                  nombre: cdp.get('nombreIntermediario') as String,
                  cuit: cdp.get('cuitIntermediario') as String),
              remitenteComercial: TransferData(
                  nombre: cdp.get('nombreRemitenteComercial') as String,
                  cuit: cdp.get('cuitRemitenteComercial') as String),
              corredorComprador: TransferData(
                  nombre: cdp.get('nombreCorredorComprador') as String,
                  cuit: cdp.get('cuitCorredorComprador') as String),
              mercadoATermino: TransferData(
                  nombre: cdp.get('nombreMercadoATermino') as String,
                  cuit: cdp.get('cuitMercadoATermino') as String),
              corredorVendedor: TransferData(
                  nombre: cdp.get('nombreCorredorVendedor') as String,
                  cuit: cdp.get('cuitCorredorVendedor') as String),
              representanteEntregador: TransferData(
                  nombre: cdp.get('nombreRepresentanteEntregador') as String,
                  cuit: cdp.get('cuitRepresentanteEntregador') as String),
              destinatario: TransferData(
                  nombre: cdp.get('nombreDestinatario') as String,
                  cuit: cdp.get('cuitDestinatario') as String),
              destino: TransferData(
                  nombre: cdp.get('nombreDestino') as String,
                  cuit: cdp.get('cuitDestino') as String),
              intermediarioDelFlete: TransferData(
                  nombre: cdp.get('nombreIntermediarioDelFlete') as String,
                  cuit: cdp.get('cuitIntermediarioDelFlete') as String),
              transportista: TransferData(
                  nombre: cdp.get('nombreTransportista') as String,
                  cuit: cdp.get('cuitTransportista') as String),
              chofer: TransferData(
                  nombre: cdp.get('nombreChofer') as String,
                  cuit: cdp.get('cuitChofer') as String),
              granoEspecie: GrainData(text: cdp.get('granoEspecie') as String),
              tipo: GrainData(text: cdp.get('tipo') as String),
              cosecha: GrainData(text: cdp.get('cosecha') as String),
              contratoNro: GrainData(text: cdp.get('contratoNro') as String),
              seraPesada: cdp.get('seraPesada') as bool,
              kgsEstimados: cdp.get('kgsEstimados') as String,
              declaracionDeCalidad:
                  GrainData(text: cdp.get('declaracionDeCalidad') as String),
              pesoBruto: GrainData(text: cdp.get('pesoBruto') as String),
              pesoTara: GrainData(text: cdp.get('pesoTara') as String),
              pesoNeto: GrainData(text: cdp.get('pesoNeto') as String),
              observaciones:
                  GrainData(text: cdp.get('observaciones') as String),
              procedenciaMercaderia: ProcedenciaMercaderia(
                direccion: cdp.get('direccionProcedenciaMercaderia') as String,
                provincia: cdp.get('provinciaProcedenciaMercaderia') as String,
                localidad: cdp.get('localidadProcedenciaMercaderia') as String,
                establecimiento:
                    cdp.get('establecimientoProcedenciaMercaderia') as String,
                renspa: cdp.get('renspaProcedenciaMercaderia') as String,
              ),
              destination: Destination(
                direccion: cdp.get('direccionDestino') as String,
                localidad: cdp.get('provinciaDestino') as String,
                provincia: cdp.get('localidadDestino') as String,
              ),
              camion: cdp.get('camion') as String,
              acoplado: cdp.get('acoplado') as String,
              kmARecorrer: cdp.get('kmARecorrer') as String,
              tarifaDeReferencia: cdp.get('tarifaDeReferencia') as String,
              tarifa: cdp.get('tarifa') as String,
              pagadorDelFlete:
                  TransportData(text: cdp.get('pagadorDelFlete') as String),
              aclarcion: cdp.get('aclaracion') as String,
              dni: cdp.get('dni') as String,
              signatureImage: Uint8List(0)),
        ),
      );
    }
    return listItems;
  }
}
