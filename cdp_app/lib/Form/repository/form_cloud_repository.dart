import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/repository/form_cloud_firestore_api.dart';
import 'package:cdp_app/Form/ui/screens/DestinationScreen/widgets/destination_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/procedencia_mercaderia_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_data_bottom_sheet_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormCloudRepository {
  final FormCloudFirestoreApi formCloudFirestoreApi = FormCloudFirestoreApi();

  ///Uploading data that will be re used in [TransferDataForm]
  Future<void> uploadTransferData({
    required TransferData? dataToUpload,
    required BuildContext context,
  }) async =>
      formCloudFirestoreApi.uploadTransferData(
          dataToUpload: dataToUpload, context: context);

  ///Uploading data that will be re used in [GrainDataForm]
  Future<void> uploadGrainData(
          {required GrainData? dataToUpload,
          required BuildContext context}) async =>
      formCloudFirestoreApi.uploadGrainData(
          dataToUpload: dataToUpload, context: context);

  ///Uploading data that will be re used in [GrainDataForm]
  Future<void> uploadProcedenciaMercaderia(
          {required ProcedenciaMercaderia? dataToUpload,
          required BuildContext context}) async =>
      formCloudFirestoreApi.uploadProcedenciaMercaderia(
          dataToUpload: dataToUpload, context: context);

  ///Uploading data that will be re used in [DestinationForm]
  Future<void> uploadDestination(
          {required Destination? dataToUpload,
          required BuildContext context}) async =>
      formCloudFirestoreApi.uploadDestination(
          dataToUpload: dataToUpload, context: context);

  ///Uploading data that will be re used in [TransportDataForm]
  Future<void> uploadTransportData(
          {required TransportData? dataToUpload,
          required BuildContext context}) async =>
      formCloudFirestoreApi.uploadTransportData(
          dataToUpload: dataToUpload, context: context);

  ///Buids a list of [TransferDataBottomSheetItem] using TransferData from Firebase
  List<TransferDataBottomSheetItem> buildTransferData(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list,
          required StateProvider<TransferData?>? providerToChange}) =>
      formCloudFirestoreApi.buildTransferData(
          list: list, providerToChange: providerToChange);

  ///Buids a list of [GrainDataBottomSheetItem] using GrainData from Firebase
  List<GrainDataBottomSheetItem> buildGrainData(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list,
          required StateProvider<GrainData?>? providerToChange}) =>
      formCloudFirestoreApi.buildGrainData(
          list: list, providerToChange: providerToChange);

  ///Buids a list of [ProcedenciaMercaderiaBottomSheetItem] using ProcedenciaMercaderia data from Firebase
  List<ProcedenciaMercaderiaBottomSheetItem> buildProcedenciaMercaderia(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list,
          required StateProvider<ProcedenciaMercaderia?>? providerToChange}) =>
      formCloudFirestoreApi.buildProcedenciaMercaderia(
          list: list, providerToChange: providerToChange);

  ///Buids a list of [DestinationBottomSheetItem] using Destination data from Firebase
  List<DestinationBottomSheetItem> buildDestination(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list,
          required StateProvider<Destination?>? providerToChange}) =>
      formCloudFirestoreApi.buildDestination(
          list: list, providerToChange: providerToChange);

  ///Buids a list of [TransportDataBottomSheetItem] using TransportData from Firebase
  List<TransportDataBottomSheetItem> buildTransportData(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list,
          required StateProvider<TransportData?>? providerToChange}) =>
      formCloudFirestoreApi.buildTransportData(
          list: list, providerToChange: providerToChange);
}
