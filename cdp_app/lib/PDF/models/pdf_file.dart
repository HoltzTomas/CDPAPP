
import 'package:cloud_firestore/cloud_firestore.dart';

class PdfFile{

  ///The user is going to upload files which contains more than one empty [CDP]
  ///with the intention of filling them.
  ///
  ///So PdfFile class contains the PdfFile's direction in Firebase Storage, the number
  ///of [CDP] that has been emited from this file, and the number of [CDP] that are
  ///still avaible.
  PdfFile({
    required this.pdfUrl,
    required this.pdfName,
    required this.disponibles,
    required this.emitidas,
    required this.time,
  });

  final String pdfUrl;
  final String pdfName;
  final double disponibles;
  final double emitidas;
  final Timestamp time;
}