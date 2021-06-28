import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_bottom_sheet_field.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_bottom_sheet.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/procedencia_bottom_sheet.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_bottom_sheet.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrainDataDropdownMenu extends StatelessWidget {
  const GrainDataDropdownMenu(
      {Key? key,
      required this.tipo,
      required this.text,
      this.providerToChange,
      this.procedenciaProviderToChange})
      : super(key: key);

  final String? tipo;
  final String? text;
  final StateProvider<GrainData?>? providerToChange;
  final StateProvider<ProcedenciaMercaderia>? procedenciaProviderToChange;

  Widget dataName() => Expanded(
        flex: 2,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

  Widget showBottomSheetButton(BuildContext context) => Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    if (tipo == "procedenciaMercaderia") {
                      return ProcedenciaBottomSheet(
                        text: text,
                        tipo: tipo,
                        providerToChange: procedenciaProviderToChange,
                      );
                    } else if (tipo == "contratoNro" ||
                        tipo == "kgsEstimados" ||
                        tipo == "pesoBruto" ||
                        tipo == "pesoTara" ||
                        tipo == "pesoNeto" ||
                        tipo == "observaciones") {
                      return GrainBottomSheetField(
                        text: text,
                        tipo: tipo,
                        providerToChange: providerToChange,
                      );
                    }
                    return GrainDataBottomSheet(
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

  Widget dataTexts() => Consumer(
        builder: (context, watch, child) {
          if (watch(providerToChange!).state!.text!.isNotEmpty) {
            return Row(
              children: [
                Expanded(
                  child: Text(watch(providerToChange!).state!.text!),
                ),
              ],
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
        },
      );

  Widget dataTextsIfProcedenciaMercaderia() => Consumer(
        builder: (context, watch, child) {
          if (watch(procedenciaProviderToChange!).state.direccion!.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          watch(procedenciaProviderToChange!).state.direccion!),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "${watch(procedenciaProviderToChange!).state.provincia!} - ${watch(procedenciaProviderToChange!).state.localidad!} - ${watch(procedenciaProviderToChange!).state.establecimiento!} "),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  "RENSPA: ${watch(procedenciaProviderToChange!).state.renspa!}",
                ),
              ],
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
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
            if (tipo == "procedenciaMercaderia") {
              return ProcedenciaBottomSheet(
                text: text,
                tipo: tipo,
                providerToChange: procedenciaProviderToChange,
              );
            } else if (tipo == "contratoNro" ||
                tipo == "kgsEstimados" ||
                tipo == "pesoBruto" ||
                tipo == "pesoTara" ||
                tipo == "pesoNeto" ||
                tipo == "observaciones") {
              return GrainBottomSheetField(
                text: text,
                tipo: tipo,
                providerToChange: providerToChange,
              );
            }
            return GrainDataBottomSheet(
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
            children: [
              Row(
                children: [
                  dataName(),
                  showBottomSheetButton(context),
                  const SizedBox(height: defaultPadding / 2),
                ],
              ),
              if (tipo != "procedenciaMercaderia") dataTexts(),
              if (tipo == "procedenciaMercaderia")
                dataTextsIfProcedenciaMercaderia(),
              if (tipo == "procedenciaMercaderia")
                const SizedBox(height: defaultPadding / 2),
            ],
          ),
        ),
      ),
    );
  }
}
