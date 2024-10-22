import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/ui/screens/form_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/issued_cdp_list_item.dart';
import 'package:cdp_app/constants.dart';
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
          .doc("${cdpData.numOfEmitionInsideTheFile + 1}. ${cdpData.cdpName}")
          .set(
        {
          'numOfEmitionInsideTheFile': file.issuedCDPs.round() + 1,
          'cdpName':
              "${cdpData.numOfEmitionInsideTheFile + 1}. ${cdpData.cdpName}",
          'ctg': cdpData.ctg,
          'fechaDeCarga': cdpData.fechaDeCarga.toString().replaceAll(":", "").replaceAll("000000.000", ""),
          'nombreTitularCartaDePorte': cdpData.titularCartaDePorte.nombre,
          'timeWhenItWasIssued': cdpData.timeWhenItWasIssued,
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
          'camionChofer': cdpData.chofer.camion,
          'acopladoChofer': cdpData.chofer.acoplado,
          'granoEspecie': cdpData.granoEspecie.text,
          'tipo': cdpData.tipo.text,
          'cosecha': cdpData.cosecha.text,
          'contratoNro': cdpData.contratoNro.text,
          'seraPesada': cdpData.seraPesada,
          'kgsEstimados': cdpData.kgsEstimados.text,
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
          'camion': cdpData.camion.text,
          'acoplado': cdpData.acoplado.text,
          'kmARecorrer': cdpData.kmARecorrer.text,
          'tarifaDeReferencia': cdpData.tarifaDeReferencia.text,
          'tarifa': cdpData.tarifa.text,
          'pagadorDelFlete': cdpData.pagadorDelFlete.text,
          'aclaracion': cdpData.aclarcion,
          'dni': cdpData.dni,
        },
      ).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: primaryColor,
            behavior: SnackBarBehavior.floating,
            content: Text('La carta de porte fue emitida con exito'),
          ),
        );
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          content: Text('No hay conexión a internet'),
        ),
      );
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
            ctg: cdp.get('ctg') as String,
            fechaDeCarga: cdp.get('fechaDeCarga') as String,
            timeWhenItWasIssued: cdp.get('timeWhenItWasIssued') as Timestamp,
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
              cuit: cdp.get('cuitChofer') as String,
              camion: cdp.get('camionChofer') as String,
              acoplado: cdp.get('acopladoChofer') as String,
            ),
            granoEspecie: GrainData(text: cdp.get('granoEspecie') as String),
            tipo: GrainData(text: cdp.get('tipo') as String),
            cosecha: GrainData(text: cdp.get('cosecha') as String),
            contratoNro: GrainData(text: cdp.get('contratoNro') as String),
            seraPesada: cdp.get('seraPesada') as bool,
            kgsEstimados: GrainData(text: cdp.get('kgsEstimados') as String),
            declaracionDeCalidad:
                GrainData(text: cdp.get('declaracionDeCalidad') as String),
            pesoBruto: GrainData(text: cdp.get('pesoBruto') as String),
            pesoTara: GrainData(text: cdp.get('pesoTara') as String),
            pesoNeto: GrainData(text: cdp.get('pesoNeto') as String),
            observaciones: GrainData(text: cdp.get('observaciones') as String),
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
            camion: TransportData(text: cdp.get('camion') as String),
            acoplado: TransportData(text: cdp.get('acoplado') as String),
            kmARecorrer: TransportData(text: cdp.get('kmARecorrer') as String),
            tarifaDeReferencia:
                TransportData(text: cdp.get('tarifaDeReferencia') as String),
            tarifa: TransportData(text: cdp.get('tarifa') as String),
            pagadorDelFlete:
                TransportData(text: cdp.get('pagadorDelFlete') as String),
            aclarcion: cdp.get('aclaracion') as String,
            dni: cdp.get('dni') as String,
          ),
        ),
      );
    }
    return listItems;
  }

  ///This method edits a CDP that has been issued, in a single PdfFile,
  ///as [IssuedCDPListItem]
  Future<void> editCDP(
      {required PdfFile file,
      required CDP cdpData,
      required BuildContext context}) async {
    firebaseCloud
        .collection(currentUser!.uid)
        .doc('pdfs')
        .collection('pdfFiles')
        .doc(file.pdfName)
        .collection('emitedCdps')
        .doc(cdpData.cdpName)
        .update(
      {
        'ctg': cdpData.ctg,
        'fechaDeCarga': cdpData.fechaDeCarga,
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
        'nombreRepresentanteEntregador': cdpData.representanteEntregador.nombre,
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
        'camionChofer': cdpData.chofer.camion,
        'acopladoChofer': cdpData.chofer.acoplado,
        'granoEspecie': cdpData.granoEspecie.text,
        'tipo': cdpData.tipo.text,
        'cosecha': cdpData.cosecha.text,
        'contratoNro': cdpData.contratoNro.text,
        'seraPesada': cdpData.seraPesada,
        'kgsEstimados': cdpData.kgsEstimados.text,
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
        'camion': cdpData.camion.text,
        'acoplado': cdpData.acoplado.text,
        'kmARecorrer': cdpData.kmARecorrer.text,
        'tarifaDeReferencia': cdpData.tarifaDeReferencia.text,
        'tarifa': cdpData.tarifa.text,
        'pagadorDelFlete': cdpData.pagadorDelFlete.text,
        'aclaracion': cdpData.aclarcion,
        'dni': cdpData.dni,
      },
    );
  }
}
