import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class ElectronicCDPScreen extends StatelessWidget {
  const ElectronicCDPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text("Carta de porte electronica"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
            child: const Text(
              "La resolución general conjunta 5017/2021 estableció que un nuevo formato electrónico de la carta de porte empezará a circular a partir del 1ero de septiembre, y será de uso obligatorio a partir del 1ero de noviembre.\n\nDejando atrás completamente el formato actual de cuatro hojas físicas.\n\nPara antes del 1ero de noviembre, CDP APP se adaptará a este nuevo formato. Para que todos ustedes puedan seguir utilizándola para emitir sus cartas de porte de la manera mas simple.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: const Text(
              "Ante cualquier duda sobre este tema, no dude en contactarnos.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
            alignment: Alignment.centerRight,
            child: const Text(
              "Equipo CDP APP",
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
