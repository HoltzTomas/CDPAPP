import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/repository/cdp_firebase_api.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfScreen/widgets/issued_cdp_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CdpCloudRepository {
  final CdpFirebaseApi cdpFirebaseApi = CdpFirebaseApi();

  void emitCDP(
          {required PdfFile file,
          required CDP cdpData,
          required String cdpName,
          required BuildContext context}) =>
      cdpFirebaseApi.emitCDP(file: file, cdpData: cdpData, cdpName: cdpName, context: context);

  List<IssuedCdpListItem> buildCDPs(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list,
          required PdfFile userFile}) =>
      cdpFirebaseApi.buildCDPs(list: list, userFile: userFile);
}
