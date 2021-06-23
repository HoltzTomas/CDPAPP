import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<GrainData> granoEspecieProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<GrainData> tipoProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<GrainData> cosechaProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<GrainData> contratoNroProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<bool> seraPesadaProvider =
    StateProvider<bool>((ref) => false);

final StateProvider<String> kgsEstimadosProvider =
    StateProvider<String>((ref) => "");

final StateProvider<GrainData> declaracionDeCalidadProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<GrainData> pesoBrutoProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: "0"));

final StateProvider<GrainData> pesoTaraProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: "0"));

final StateProvider<GrainData> pesoNetoProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<GrainData> observacionesProvider =
    StateProvider<GrainData>((ref) => GrainData(tipo: "", text: ""));

final StateProvider<ProcedenciaMercaderia> procedenciaProvider =
    StateProvider<ProcedenciaMercaderia>((ref) => ProcedenciaMercaderia(
          direccion: "",
          provincia: "",
          localidad: "",
          establecimiento: "",
          renspa: "",
        ));