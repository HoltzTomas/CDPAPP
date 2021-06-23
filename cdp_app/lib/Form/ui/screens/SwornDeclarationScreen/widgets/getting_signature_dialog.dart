import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cdp_app/Form/providers/sworn_declaration_providers.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'mobile_image_converter.dart';

class GetSignatureDialog extends ConsumerWidget {
  GetSignatureDialog({Key? key}) : super(key: key);
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  Widget title() => const Text(
        'Escribi tu firma',
        style: TextStyle(
            color: darkColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto-Medium'),
      );

  Widget deleteSignatureButton(ScopedReader watch, BuildContext context) =>
      TextButton(
        onPressed: () {
          watch(isSignatureProvided).state = false;
          watch(signatureImageProvider).state = Uint8List(0);
          Navigator.pop(context);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child: const Text(
          'Borrar',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto-Medium',
              color: darkColor),
        ),
      );

  Widget saveSignatureButton(ScopedReader watch, BuildContext context) =>
      TextButton(
        onPressed: () async {
          late Uint8List data;

          if (kIsWeb) {
            final RenderSignaturePad renderSignaturePad =
                _signaturePadKey.currentState!.context.findRenderObject()
                    as RenderSignaturePad;
            data = await ImageConverter.toImage(
                renderSignaturePad: renderSignaturePad);
          } else {
            final imageData =
                await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
            final bytes =
                await imageData.toByteData(format: ui.ImageByteFormat.png);
            if (bytes != null) {
              data = bytes.buffer.asUint8List();
            }
          }

          watch(isSignatureProvided).state = true;
          watch(signatureImageProvider).state = data;
          Navigator.pop(context);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child: const Text(
          'Guardar',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto-Medium',
              color: darkColor),
        ),
      );

  Widget signaturePad(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width < 306
            ? MediaQuery.of(context).size.width
            : 306,
        height: 172,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
        ),
        child: SfSignaturePad(
            minimumStrokeWidth: 1,
            maximumStrokeWidth: 3,
            strokeColor: darkColor,
            backgroundColor: whiteColor,
            key: _signaturePadKey),
      );

  Widget closeButton(BuildContext context) => InkWell(
        onTap: () => {Navigator.of(context).pop()},
        child: const Icon(Icons.clear, color: darkColor, size: 24.0),
      );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(12.0),
      backgroundColor: whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title(),
          closeButton(context),
        ],
      ),
      titlePadding: const EdgeInsets.all(16.0),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 306
              ? MediaQuery.of(context).size.width
              : 306,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              signaturePad(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      actions: [
        deleteSignatureButton(watch, context),
        const SizedBox(width: 8.0),
        saveSignatureButton(watch, context)
      ],
    );
  }
}
