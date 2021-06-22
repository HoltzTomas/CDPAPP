import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<TransferData> titularCartaDePorteProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> intermediarioProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> remitenteComercialProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> corredorCompradorProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> mercadoATerminoProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> corredorVendedorProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> representanteEntregadorProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> destinatarioProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> destinoProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> intermediarioDelFleteProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> transportistaProvider =
    StateProvider((ref) => TransferData(tipo: "", nombre: "", cuit: ""));

final StateProvider<TransferData> choferProvider = StateProvider((ref) =>
    TransferData(tipo: "", nombre: "", cuit: "", camion: "", acoplado: ""));