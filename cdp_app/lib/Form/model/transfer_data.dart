import 'package:flutter/material.dart';

class TransferData {
  String? tipo;
  String? nombre;
  String? cuit;
  String? camion;
  String? acoplado;

  TransferData({
    @required this.tipo,
    @required this.nombre,
    @required this.cuit,
    this.camion,
    this.acoplado,
  });
}
