import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> camionProvider = StateProvider<String>((ref) => "");
final StateProvider<String> acopladoProvider = StateProvider<String>((ref) => "");
final StateProvider<String> kmARecorrerProvider = StateProvider<String>((ref) => "");
final StateProvider<String> tarifaDeReferenciaProvider =
    StateProvider<String>((ref) => "");
final StateProvider<String> tarifaProvider = StateProvider<String>((ref) => "");
final StateProvider<TransportData> pagadorDelFleteProvider =
    StateProvider<TransportData>((ref) => TransportData(tipo: "", text: ""));