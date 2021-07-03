import 'dart:io';
import 'dart:ui';

import 'package:cdp_app/CDP/models/cdp.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CdpApi {
  ///User can copy data from a [CDP] that has been issued before and use that for a
  ///new one.
  ///
  ///[IssuedCDPListItem] receives a [CDP] as a parameter. In this function,
  ///we use this [CDP]'s data to modify the providers and fill the form.
  void copyCDP(BuildContext context,
      {required PdfFile pdfFile, required CDP cdp}) {
    ///Copying [TransferDataProviders]
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

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: FormScreen(
          pdfFile: pdfFile,
        ),
      ),
    );
  }

  ///This method use [CDP]'s data to fill [PdfFile]
  Future<void> fillPdfFileWithCdpData(
      {required PdfFile file, required CDP cdp}) async {
    final pdfReference = FirebaseStorage.instance.ref().child(file.pdfUrl);
    final filebytes = await pdfReference.getData();
    final PdfDocument document = PdfDocument(inputBytes: filebytes);

    deleteExtraPages(document: document, cdp: cdp);

    fillTransferDataForm(document: document, cdpPdf: cdp);
    fillGrainDataDataForm(document: document, cdpPdf: cdp);
    fillDestinationForm(document: document, cdpPdf: cdp);
    fillTransportDataForm(document: document, cdpPdf: cdp);
    fillSwornDeclarationForm(document: document, cdpPdf: cdp);

    final List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, "${cdp.cdpName}.pdf");
  }

  void _addString(
      String string, PdfPage page, double left, double top, double textSize) {
    page.graphics.drawString(
        string, PdfStandardFont(PdfFontFamily.helvetica, textSize),
        bounds: Rect.fromLTWH(left, top, 440, 550));
  }

  void _addPoint(PdfPage page, double left, double top, double pointSize) {
    page.graphics.drawString(
        '*', PdfStandardFont(PdfFontFamily.helvetica, pointSize),
        bounds: Rect.fromLTWH(left, top, 440, 550), pen: PdfPens.black);
  }

  void addStringInAllPages(List<PdfPage> pages, String string, double left,
      double top, double textSize) {
    for (final PdfPage page in pages) {
      _addString(string, page, left, top, textSize);
    }
  }

  void addPointInAllPages(
      List<PdfPage> pages, double left, double top, double pointSize) {
    for (final PdfPage page in pages) {
      _addPoint(page, left, top, pointSize);
    }
  }

  ///Each [PdfFile] contains more then 1 [CDP] (4 Pages each CDP).
  ///
  ///So, using [numOfEmitionInsideTheFile] we are going to use the CDP that we want
  void deleteExtraPages({required PdfDocument document, required CDP cdp}) {
    for (var i = document.pages.count;
        i > (cdp.numOfEmitionInsideTheFile * 4) - 1;
        i--) {
      document.pages.removeAt(i);
    }
    for (var i = 0; i < ((cdp.numOfEmitionInsideTheFile - 1) * 4); i++) {
      document.pages.removeAt(0);
    }
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  ///We are adding the data the we got in [TransferDataForm] into the PDF
  void fillTransferDataForm({required PdfDocument document, CDP? cdpPdf}) {
    final page1 = document.pages[0];
    final page2 = document.pages[1];
    final page3 = document.pages[2];
    final page4 = document.pages[3];
    final List<PdfPage> cdpPages = [page1, page2, page3, page4];

    ///Adding Intermediario [nombre] & [cuit] to each page
    addStringInAllPages(cdpPages, cdpPdf!.intermediario.nombre!, 180, 150, 12);
    addStringInAllPages(cdpPages, cdpPdf.intermediario.cuit!, 475, 150, 12);

    ///Adding Remitente comercial [nombre] & [cuit]
    addStringInAllPages(
        cdpPages, cdpPdf.remitenteComercial.nombre!, 180, 170, 12);
    addStringInAllPages(
        cdpPages, cdpPdf.remitenteComercial.cuit!, 475, 170, 12);

    ///Adding Corredor comprador [nombre] & [cuit]
    addStringInAllPages(
        cdpPages, cdpPdf.corredorComprador.nombre!, 180, 190, 12);
    addStringInAllPages(cdpPages, cdpPdf.corredorComprador.cuit!, 475, 190, 12);

    ///Adding Mercado a termino [nombre] & [cuit]
    addStringInAllPages(cdpPages, cdpPdf.mercadoATermino.nombre!, 180, 210, 12);
    addStringInAllPages(cdpPages, cdpPdf.mercadoATermino.cuit!, 475, 210, 12);

    ///Adding Corredor vendedor [nombre] & [cuit]
    addStringInAllPages(
        cdpPages, cdpPdf.corredorVendedor.nombre!, 180, 230, 12);
    addStringInAllPages(cdpPages, cdpPdf.corredorVendedor.cuit!, 475, 230, 12);

    ///Adding Representante Entregador [nombre] & [cuit]
    addStringInAllPages(
        cdpPages, cdpPdf.representanteEntregador.nombre!, 180, 250, 12);
    addStringInAllPages(
        cdpPages, cdpPdf.representanteEntregador.cuit!, 475, 250, 12);

    ///Adding Destinatario [nombre] & [cuit]
    addStringInAllPages(cdpPages, cdpPdf.destinatario.nombre!, 180, 270, 12);
    addStringInAllPages(cdpPages, cdpPdf.destinatario.cuit!, 475, 270, 12);

    ///Adding Destino [nombre] & [cuit]
    addStringInAllPages(cdpPages, cdpPdf.destino.nombre!, 180, 290, 12);
    addStringInAllPages(cdpPages, cdpPdf.destino.cuit!, 475, 290, 12);

    ///Adding Intermediario del flete [nombre] & [cuit]
    addStringInAllPages(
        cdpPages, cdpPdf.intermediarioDelFlete.nombre!, 180, 310, 12);
    addStringInAllPages(
        cdpPages, cdpPdf.intermediarioDelFlete.cuit!, 475, 310, 12);

    ///Adding Transportista [nombre] & [cuit]
    addStringInAllPages(cdpPages, cdpPdf.transportista.nombre!, 180, 330, 12);
    addStringInAllPages(cdpPages, cdpPdf.transportista.cuit!, 475, 330, 12);

    ///Adding Chofer [nombre] & [cuit]
    addStringInAllPages(cdpPages, cdpPdf.chofer.nombre!, 180, 350, 12);
    addStringInAllPages(cdpPages, cdpPdf.chofer.cuit!, 475, 350, 12);
    //TODO: CAMION Y ACOPLADO
  }

  ///We are adding the data the we got in [GrainDataForm] into the PDF
  void fillGrainDataDataForm({required PdfDocument document, CDP? cdpPdf}) {
    final page1 = document.pages[0];
    final page2 = document.pages[1];
    final page3 = document.pages[2];
    final page4 = document.pages[3];
    final List<PdfPage> cdpPages = [page1, page2, page3, page4];

    ///Adding Grano Especie [text]
    addStringInAllPages(cdpPages, cdpPdf!.granoEspecie.text!, 130, 370, 12);

    ///Adding Tipo [text]
    addStringInAllPages(cdpPages, cdpPdf.tipo.text!, 230, 372, 8);

    ///Adding ContratoNro [text]
    addStringInAllPages(cdpPages, cdpPdf.contratoNro.text!, 490, 370, 10);

    ///Adding Cosecha [text]
    addStringInAllPages(cdpPages, cdpPdf.cosecha.text!, 360, 370, 12);

    ///Adding Sera pesada [bool]
    if (cdpPdf.seraPesada == true) addPointInAllPages(cdpPages, 132, 402, 20);

    ///Adding Kgs Estimados [text]
    addStringInAllPages(cdpPages, cdpPdf.kgsEstimados.text!, 125, 422, 9);

    ///Adding Declaracion de calidad [bool]
    if (cdpPdf.declaracionDeCalidad.text == "Conforme") {
      addPointInAllPages(cdpPages, 257, 404, 20);
    }
    if (cdpPdf.declaracionDeCalidad.text == "Condicional") {
      addPointInAllPages(cdpPages, 257, 420, 20);
    }

    ///Adding Peso Bruto [text]
    if (cdpPdf.seraPesada == false) {
      addStringInAllPages(cdpPages, cdpPdf.pesoBruto.text!, 350, 386, 10);
    }

    ///Adding Peso Tara [text]
    if (cdpPdf.seraPesada == false) {
      addStringInAllPages(cdpPages, cdpPdf.pesoTara.text!, 350, 404, 10);
    }

    ///Adding Peso Neto [text]
    if (cdpPdf.seraPesada == false) {
      addStringInAllPages(cdpPages, cdpPdf.pesoNeto.text!, 350, 422, 10);
    }

    ///Adding Observaciones [text]
    addStringInAllPages(cdpPages, cdpPdf.observaciones.text!, 410, 400, 9);

    ///Adding Procedencia Mercaderia [direccion], [establecimiento], [localidad]
    ///& [provincia]
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.direccion!, 110, 455, 15);
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.establecimiento!, 425, 439, 7.5);
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.localidad!, 425, 452, 7.5);
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.provincia!, 425, 467, 7.5);
  }

  ///We are adding the data the we got in [DestinationForm] into the PDF
  void fillDestinationForm({required PdfDocument document, CDP? cdpPdf}) {
    final page1 = document.pages[0];
    final page2 = document.pages[1];
    final page3 = document.pages[2];
    final page4 = document.pages[3];
    final List<PdfPage> cdpPages = [page1, page2, page3, page4];

    ///Adding Destination [Direccion]
    addStringInAllPages(cdpPages, cdpPdf!.destination.direccion!, 75, 502, 12);

    ///Adding Destination [Localidad]
    addStringInAllPages(cdpPages, cdpPdf.destination.provincia!, 360, 502, 12);

    ///Adding Destination [Provincia]
    addStringInAllPages(cdpPages, cdpPdf.destination.localidad!, 360, 485, 12);
  }

  ///We are adding the data the we got in [TransportDataForm] into the PDF
  void fillTransportDataForm({required PdfDocument document, CDP? cdpPdf}) {
    final page1 = document.pages[0];
    final page2 = document.pages[1];
    final page3 = document.pages[2];
    final page4 = document.pages[3];
    final List<PdfPage> cdpPages = [page1, page2, page3, page4];

    ///Adding Camion [text]
    addStringInAllPages(cdpPages, cdpPdf!.camion.text!, 95, 540, 10);

    ///Adding Acoplado [text]
    addStringInAllPages(cdpPages, cdpPdf.acoplado.text!, 95, 557, 10);

    ///Adding Kms a recorrer [text]
    addStringInAllPages(cdpPages, cdpPdf.kmARecorrer.text!, 95, 574, 10);

    ///Adding Tarifa de referencia [text]
    addStringInAllPages(
        cdpPages, cdpPdf.tarifaDeReferencia.text!, 240, 557, 10);

    ///Adding Tarifa [text]
    addStringInAllPages(cdpPages, cdpPdf.tarifa.text!, 240, 574, 10);

    ///Adding Pagador del flete [text]
    addStringInAllPages(cdpPages, cdpPdf.pagadorDelFlete.text!, 345, 522, 10);
  }

  ///We are adding the data the we got in [SwornDeclarationForm] into the PDF
  void fillSwornDeclarationForm({required PdfDocument document, CDP? cdpPdf}) {
    final page1 = document.pages[0];
    final page2 = document.pages[1];
    final page3 = document.pages[2];
    final page4 = document.pages[3];
    final List<PdfPage> cdpPages = [page1, page2, page3, page4];

    ///Adding Aclaracion [text] to each page
    addStringInAllPages(cdpPages, cdpPdf!.aclarcion, 300, 816, 9);

    ///Adding D.N.I to [text] each page
    addStringInAllPages(cdpPages, cdpPdf.dni, 457, 817, 9);
  }
}
