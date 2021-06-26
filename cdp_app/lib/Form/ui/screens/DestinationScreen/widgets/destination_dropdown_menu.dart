import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/ui/screens/DestinationScreen/widgets/destination_bottom_sheet.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DestinationDropdownMenu extends StatelessWidget {
  const DestinationDropdownMenu({
    Key? key,
    required this.tipo,
    required this.text,
    this.providerToChange,
  }) : super(key: key);

  final String? tipo;
  final String? text;
  final StateProvider<Destination?>? providerToChange;

  Widget showBottomSheetButton(BuildContext context) => Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return DestinationBottomSheet(
                      text: text,
                      tipo: tipo,
                      providerToChange: providerToChange,
                    );
                  },
                );
              },
              icon: const Icon(Icons.arrow_drop_down)),
        ),
      );

  Widget dataName() => Expanded(
        flex: 2,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

  Widget selectedDataTexts() => Consumer(
        builder: (context, watch, child) {
          return Column(
            children: [
              if (watch(providerToChange!).state!.direccion!.isNotEmpty)
                Text(
                    "Direccion: ${watch(providerToChange!).state!.direccion!}"),
              if (watch(providerToChange!).state!.provincia!.isNotEmpty)
                const SizedBox(height: defaultPadding / 2),
              if (watch(providerToChange!).state!.provincia!.isNotEmpty)
                Text(
                    "Provincia: ${watch(providerToChange!).state!.provincia!}"),
              if (watch(providerToChange!).state!.localidad!.isNotEmpty)
                const SizedBox(height: defaultPadding / 2),
              if (watch(providerToChange!).state!.localidad!.isNotEmpty)
                Text(
                    "Localidad: ${watch(providerToChange!).state!.localidad!}"),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return DestinationBottomSheet(
              text: text,
              tipo: tipo,
              providerToChange: providerToChange,
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        margin: const EdgeInsets.all(defaultPadding / 2),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  dataName(),
                  showBottomSheetButton(context),
                  selectedDataTexts()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
