import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> aclaracionProvider =
    StateProvider<String>((ref) => "");
final StateProvider<String> dniProvider = StateProvider<String>((ref) => "");

final StateProvider<Uint8List> signatureImageProvider =
    StateProvider((ref) => Uint8List(0));
final StateProvider<bool> isSignatureProvided =
    StateProvider<bool>((ref) => false);