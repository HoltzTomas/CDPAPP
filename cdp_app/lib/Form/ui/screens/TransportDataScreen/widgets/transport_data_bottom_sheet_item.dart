import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransportDataBottomSheetItem extends ConsumerWidget {
  const TransportDataBottomSheetItem(
      {Key? key, required this.data, this.providerToChange})
      : super(key: key);

  final TransportData? data;
  final StateProvider<TransportData?>? providerToChange;

  Widget selectDataButton(BuildContext context) => TextButton(
        onPressed: () {
          context.read(providerToChange!).state = data;
          Navigator.pop(context);
        },
        child: const Text("Seleccionar", style: TextStyle(color: darkColor),),
      );

  Widget title() => Text(
        data!.text!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

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
            title(),
            const Spacer(),
            selectDataButton(context),
          ],
        ),
      ),
    );
  }
}
