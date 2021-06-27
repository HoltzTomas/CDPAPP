import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<TransportData> camionProvider =
    StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));
final StateProvider<TransportData> acopladoProvider =
    StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));
final StateProvider<TransportData> kmARecorrerProvider =
    StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));
final StateProvider<TransportData> tarifaDeReferenciaProvider =
    StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));
final StateProvider<TransportData> tarifaProvider = StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));
final StateProvider<TransportData> pagadorDelFleteProvider =
    StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));
