import 'dart:io';
import 'dart:ui';

import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CdpApi {
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

    saveAndLaunchFile(bytes, 'CDP.pdf');
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

  void _addImage(PdfPage page, double left, double top, double width,
      double height, List<int> bytes) {
    page.graphics
        .drawImage(PdfBitmap(bytes), Rect.fromLTWH(left, top, width, height));
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

  void addImageInAllPages(List<PdfPage> pages, double left, double top,
      double width, double height, List<int> bytes) {
    for (final PdfPage page in pages) {
      _addImage(page, left, top, width, height, bytes);
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

    ///Adding Transportista [nombre] & [cuit]
    addStringInAllPages(cdpPages, cdpPdf.chofer.nombre!, 180, 350, 12);
    addStringInAllPages(cdpPages, cdpPdf.chofer.cuit!, 475, 350, 12);
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
    addStringInAllPages(cdpPages, cdpPdf.tipo.text!, 230, 370, 12);

    ///Adding ContratoNro [text]
    addStringInAllPages(cdpPages, cdpPdf.contratoNro.text!, 490, 370, 12);

    ///Adding Cosecha [text]
    addStringInAllPages(cdpPages, cdpPdf.cosecha.text!, 360, 370, 12);

    ///Adding Sera pesada [bool]
    if (cdpPdf.seraPesada == true) addPointInAllPages(cdpPages, 132, 402, 20);

    ///Adding Kgs Estimados [text]
    addStringInAllPages(cdpPages, cdpPdf.kgsEstimados, 125, 422, 9);

    ///Adding Declaracion de calidad [bool]
    if (cdpPdf.declaracionDeCalidad.text == "Conforme") {
      addPointInAllPages(cdpPages, 257, 404, 20);
    }
    if (cdpPdf.declaracionDeCalidad.text == "Condicional") {
      addPointInAllPages(cdpPages, 257, 420, 20);
    }

    ///Adding Peso Bruto [text]
    if (cdpPdf.seraPesada == false)
      addStringInAllPages(cdpPages, cdpPdf.pesoBruto.text!, 350, 386, 10);

    ///Adding Peso Tara [text]
    if (cdpPdf.seraPesada == false)
      addStringInAllPages(cdpPages, cdpPdf.pesoTara.text!, 350, 404, 10);

    ///Adding Peso Neto [text]
    if (cdpPdf.seraPesada == false)
      addStringInAllPages(cdpPages, cdpPdf.pesoNeto.text!, 350, 422, 10);

    ///Adding Observaciones [text]
    addStringInAllPages(cdpPages, cdpPdf.observaciones.text!, 410, 400, 9);

    ///Adding Procedencia Mercaderia [direccion], [establecimiento], [localidad]
    ///& [provincia]
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.direccion!, 110, 455, 15);
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.establecimiento!, 425, 439, 10);
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.localidad!, 425, 452, 10);
    addStringInAllPages(
        cdpPages, cdpPdf.procedenciaMercaderia.provincia!, 425, 467, 10);
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
    addStringInAllPages(cdpPages, cdpPdf!.camion, 95, 540, 10);

    ///Adding Acoplado [text]
    addStringInAllPages(cdpPages, cdpPdf.acoplado, 95, 557, 10);

    ///Adding Kms a recorrer [text]
    addStringInAllPages(cdpPages, cdpPdf.kmARecorrer, 95, 574, 10);

    ///Adding Tarifa de referencia [text]
    addStringInAllPages(cdpPages, cdpPdf.tarifaDeReferencia, 240, 557, 10);

    ///Adding Tarifa [text]
    addStringInAllPages(cdpPages, cdpPdf.tarifa, 240, 574, 10);

    ///Adding Pagador del flete [text]
    addStringInAllPages(cdpPages, cdpPdf.pagadorDelFlete.text!, 345, 522, 10);
  }
  
  ///We are adding the data the we got in [SwornDeclarationForm] into the PDF
  void fillSwornDeclarationForm(
      {required PdfDocument document, CDP? cdpPdf}) {
    final page1 = document.pages[0];
    final page2 = document.pages[1];
    final page3 = document.pages[2];
    final page4 = document.pages[3];
    final List<PdfPage> cdpPages = [page1, page2, page3, page4];

    ///Adding Aclaracion [text] to each page
    addStringInAllPages(cdpPages, cdpPdf!.aclarcion, 300, 816, 9);

    ///Adding D.N.I to [text] each page
    addStringInAllPages(cdpPages, cdpPdf.dni, 457, 817, 9);

    ///Adding Signature to each page
    /// TODO: addImageInAllPages(cdpPages, 320, 540, 100, 30, cdpPdf.signatureImage);
    //addImageInAllPages(cdpPages, 110, 815, 50, 25, cdpPdf.signatureImage);
  }
}
