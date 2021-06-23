import 'package:cdp_app/Form/model/destination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<Destination> destinationProvider =
    StateProvider<Destination>((ref) => Destination(
          direccion: "",
          provincia: "",
          localidad: "",
        ));