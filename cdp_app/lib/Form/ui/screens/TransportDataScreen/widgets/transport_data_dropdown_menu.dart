import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_bottom_sheet_field.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_data_bottom_sheet.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransportDataDropdownMenu extends ConsumerWidget {
  const TransportDataDropdownMenu({
    Key? key,
    required this.tipo,
    required this.text,
    this.providerToChange,
  }) : super(key: key);

  final String? tipo;
  final String? text;
  final StateProvider<TransportData>? providerToChange;

  Widget showBottomSheetButton(BuildContext context) => Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    if (tipo == "pagadorDelFlete") {
                      return TransportDataBottomSheet(
                        text: text,
                        tipo: tipo,
                        providerToChange: providerToChange,
                      );
                    } else {
                      return TransportBottomSheetField(text: text, tipo: tipo, providerToChange: providerToChange,);
                    }
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

  Widget dataText() => Consumer(
        builder: (context, watch, child) {
          if (watch(providerToChange!).state.text!.isNotEmpty) {
            return Text(watch(providerToChange!).state.text!);
          }
          return const SizedBox(height: 0, width: 0);
        },
      );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            if (tipo == "pagadorDelFlete") {
              return TransportDataBottomSheet(
                text: text,
                tipo: tipo,
                providerToChange: providerToChange,
              );
            } else {
              return TransportBottomSheetField(text: text, tipo: tipo, providerToChange: providerToChange,);
            }
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
                ],
              ),
              dataText()
            ],
          ),
        ),
      ),
    );
  }
}
