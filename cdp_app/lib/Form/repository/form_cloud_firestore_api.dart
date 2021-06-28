import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/ui/screens/DestinationScreen/widgets/destination_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/procedencia_mercaderia_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_bottom_sheet_item.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_data_bottom_sheet_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormCloudFirestoreApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  ///Data Collections
  final String transferData = "transferData";
  final String grainData = "grainData";
  final String procedenciaMercaderia = "procedenciaMercaderia";
  final String destination = "destination";
  final String transportData = "transportData";

  ///Uploading data that will be re used in [TransferDataForm]
  Future<void> uploadTransferData({
    required TransferData? dataToUpload,
    required BuildContext context,
  }) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final CollectionReference<Map<String, dynamic>> reference =
          firebaseFirestore
              .collection(currentUser!.uid)
              .doc('userData')
              .collection(transferData);

      await reference.doc(dataToUpload!.nombre).set(
        {
          'tipo': dataToUpload.tipo,
          'nombre': dataToUpload.nombre,
          'cuit': dataToUpload.cuit,
          'camion': dataToUpload.camion,
          'acoplado': dataToUpload.acoplado
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay coneccion a internet"),
        ),
      );
    }
  }

  ///Uploading data that will be re used in [GrainDataForm]
  Future<void> uploadGrainData(
      {required GrainData? dataToUpload, required BuildContext context}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final CollectionReference<Map<String, dynamic>> reference =
          firebaseFirestore
              .collection(currentUser!.uid)
              .doc('userData')
              .collection(grainData);

      await reference.doc(dataToUpload!.text).set(
        {
          'tipo': dataToUpload.tipo,
          'text': dataToUpload.text,
          'trueOrFalse': dataToUpload.trueOrFalse,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay coneccion a internet"),
        ),
      );
    }
  }

  ///Uploading data that will be re used in [GrainDataForm]
  Future<void> uploadProcedenciaMercaderia(
      {required ProcedenciaMercaderia? dataToUpload,
      required BuildContext context}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final CollectionReference<Map<String, dynamic>> reference =
          firebaseFirestore
              .collection(currentUser!.uid)
              .doc('userData')
              .collection(procedenciaMercaderia);

      await reference.doc(dataToUpload!.direccion).set(
        {
          'direccion': dataToUpload.direccion,
          'provincia': dataToUpload.provincia,
          'localidad': dataToUpload.localidad,
          'establecimiento': dataToUpload.establecimiento,
          'renspa': dataToUpload.renspa,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay coneccion a internet"),
        ),
      );
    }
  }

  ///Uploading data that will be re used in [DestinationForm]
  Future<void> uploadDestination(
      {required Destination? dataToUpload,
      required BuildContext context}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final CollectionReference<Map<String, dynamic>> reference =
          firebaseFirestore
              .collection(currentUser!.uid)
              .doc('userData')
              .collection(destination);

      await reference.doc(dataToUpload!.direccion).set(
        {
          'direccion': dataToUpload.direccion,
          'provincia': dataToUpload.provincia,
          'localidad': dataToUpload.localidad,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay coneccion a internet"),
        ),
      );
    }
  }

  ///Uploading data that will be re used in [TransportDataForm]
  Future<void> uploadTransportData(
      {required TransportData? dataToUpload,
      required BuildContext context}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final CollectionReference<Map<String, dynamic>> reference =
          firebaseFirestore
              .collection(currentUser!.uid)
              .doc('userData')
              .collection(transportData);

      await reference.doc(dataToUpload!.text).set(
        {
          'tipo': dataToUpload.tipo,
          'text': dataToUpload.text,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay coneccion a internet"),
        ),
      );
    }
  }

  ///Buids a list of [TransferDataBottomSheetItem] using TransferData from Firebase
  List<TransferDataBottomSheetItem> buildTransferData(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list,
      required StateProvider<TransferData?>? providerToChange}) {
    final List<TransferDataBottomSheetItem> itemsList =
        <TransferDataBottomSheetItem>[];
    for (final item in list) {
      itemsList.add(
        TransferDataBottomSheetItem(
          data: TransferData(
            tipo: item.get('tipo') as String,
            nombre: item.get('nombre') as String,
            cuit: item.get('cuit') as String,
            camion: item.get('camion') as String?,
            acoplado: item.get('acoplado') as String?,
          ),
          providerToChange: providerToChange,
        ),
      );
    }
    return itemsList;
  }

  ///Buids a list of [GrainDataBottomSheetItem] using GrainData from Firebase
  List<GrainDataBottomSheetItem> buildGrainData(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list,
      required StateProvider<GrainData?>? providerToChange}) {
    final List<GrainDataBottomSheetItem> itemsList =
        <GrainDataBottomSheetItem>[];
    for (final item in list) {
      itemsList.add(
        GrainDataBottomSheetItem(
          data: GrainData(
            tipo: item.get('tipo') as String,
            text: item.get('text') as String,
            trueOrFalse: item.get('trueOrFalse') as bool,
          ),
          providerToChange: providerToChange,
        ),
      );
    }
    return itemsList;
  }

  ///Buids a list of [ProcedenciaMercaderiaBottomSheetItem] using ProcedenciaMercaderia data from Firebase
  List<ProcedenciaMercaderiaBottomSheetItem> buildProcedenciaMercaderia(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list,
      required StateProvider<ProcedenciaMercaderia?>? providerToChange}) {
    final List<ProcedenciaMercaderiaBottomSheetItem> itemsList =
        <ProcedenciaMercaderiaBottomSheetItem>[];
    for (final item in list) {
      itemsList.add(
        ProcedenciaMercaderiaBottomSheetItem(
          data: ProcedenciaMercaderia(
            direccion: item.get('direccion') as String,
            provincia: item.get('provincia') as String,
            localidad: item.get('localidad') as String,
            establecimiento: item.get('establecimiento') as String,
            renspa: item.get('renspa') as String,
          ),
          providerToChange: providerToChange,
        ),
      );
    }
    return itemsList;
  }

  ///Buids a list of [DestinationBottomSheetItem] using Destination data from Firebase
  List<DestinationBottomSheetItem> buildDestination(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list,
      required StateProvider<Destination?>? providerToChange}) {
    final List<DestinationBottomSheetItem> itemsList =
        <DestinationBottomSheetItem>[];
    for (final item in list) {
      itemsList.add(
        DestinationBottomSheetItem(
          data: Destination(
            direccion: item.get('direccion') as String,
            provincia: item.get('provincia') as String,
            localidad: item.get('localidad') as String,
          ),
          providerToChange: providerToChange,
        ),
      );
    }
    return itemsList;
  }

  ///Buids a list of [TransportDataBottomSheetItem] using TransportData from Firebase
  List<TransportDataBottomSheetItem> buildTransportData(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list,
      required StateProvider<TransportData?>? providerToChange}) {
    final List<TransportDataBottomSheetItem> itemsList =
        <TransportDataBottomSheetItem>[];
    for (final item in list) {
      itemsList.add(
        TransportDataBottomSheetItem(
          data: TransportData(
            tipo: item.get('tipo') as String,
            text: item.get('text') as String,
          ),
          providerToChange: providerToChange,
        ),
      );
    }
    return itemsList;
  }
}
