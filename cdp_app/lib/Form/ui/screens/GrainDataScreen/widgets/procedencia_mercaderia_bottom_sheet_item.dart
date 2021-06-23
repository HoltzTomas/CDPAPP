import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProcedenciaMercaderiaBottomSheetItem extends ConsumerWidget {
  const ProcedenciaMercaderiaBottomSheetItem(
      {Key? key, required this.data, this.providerToChange})
      : super(key: key);

  final ProcedenciaMercaderia? data;
  final StateProvider<ProcedenciaMercaderia?>? providerToChange;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return GestureDetector(
      onTap: () {
        context.read(providerToChange!).state = data;
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(defaultPadding / 2),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Text(
              data!.direccion!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.read(providerToChange!).state = data;
                Navigator.pop(context);
              },
              child: const Text("Seleccionar"),
            )
          ],
        ),
      ),
    );
  }
}
