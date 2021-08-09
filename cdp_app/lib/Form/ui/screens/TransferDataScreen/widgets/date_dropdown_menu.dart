import 'package:cdp_app/Form/providers/transfer_data_providers.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateDropdownMenu extends ConsumerWidget {
  const DateDropdownMenu({
    Key? key,
  }) : super(key: key);
  Widget arrowButton(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () async {
            context.read(fechaDeCargaProvider).state = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.utc(2021, 1, 1),
              lastDate: DateTime.utc(2023, 1, 1),
            );
          },
          icon: const Icon(Icons.arrow_drop_down),
        ),
      );

  Widget deleteButton(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            context.read(fechaDeCargaProvider).state = null;
          },
          icon: const Icon(Icons.delete),
        ),
      );

  Widget selectButton() {
    return Consumer(
      builder: (context, watch, child) {
        if (watch(fechaDeCargaProvider).state != null) {
          return deleteButton(context);
        } else {
          return arrowButton(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      margin: const EdgeInsets.all(defaultPadding / 2),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    "Fecha de carga",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: selectButton())
              ],
            ),
            if (watch(fechaDeCargaProvider).state != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(watch(fechaDeCargaProvider).state!.toString().replaceAll(":", "").replaceAll("000000.000", "")),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
