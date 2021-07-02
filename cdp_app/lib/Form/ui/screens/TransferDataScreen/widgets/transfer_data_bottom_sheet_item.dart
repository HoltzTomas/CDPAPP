import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferDataBottomSheetItem extends ConsumerWidget {
  const TransferDataBottomSheetItem(
      {Key? key, required this.data, this.providerToChange})
      : super(key: key);

  final TransferData? data;
  final StateProvider<TransferData?>? providerToChange;

  Widget dataName() => Text(
        data!.nombre!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Widget selectDataButton(BuildContext context) => TextButton(
        onPressed: () {
          context.read(providerToChange!).state = data;
          Navigator.pop(context);
        },
        child: const Text(
          "Seleccionar",
          style: TextStyle(color: primaryColor),
        ),
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
            dataName(),
            const Spacer(),
            selectDataButton(context),
          ],
        ),
      ),
    );
  }
}
