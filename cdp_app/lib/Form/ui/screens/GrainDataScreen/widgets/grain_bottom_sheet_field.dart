import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrainBottomSheetField extends StatefulWidget {
  final String? text;
  final String? tipo;
  final StateProvider<GrainData?>? providerToChange;

  const GrainBottomSheetField(
      {Key? key,
      @required this.text,
      required this.tipo,
      this.providerToChange})
      : super(key: key);

  @override
  _GrainBottomSheetFieldState createState() => _GrainBottomSheetFieldState();
}

class _GrainBottomSheetFieldState extends State<GrainBottomSheetField> {
  final TextEditingController controller = TextEditingController();

  Widget addDataButton(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  context.read(widget.providerToChange!).state = GrainData(
                    tipo: widget.tipo,
                    text: controller.text.trim(),
                  );
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Agregar",
                style: TextStyle(color: darkColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
        ],
      );

  Widget textField() {
    TextInputType selectInputType() {
      if (widget.tipo == "pesoBruto" ||
          widget.tipo == "pesoTara" ||
          widget.tipo == "pesoNeto" ||
          widget.tipo == "kgsEstimados") {
        return TextInputType.number;
      } else {
        return TextInputType.text;
      }
    }

    return Container(
      child: FormTextField(
          dataWeWantReceive: "${widget.text} (Escriba aqui)",
          controller: controller,
          maxLength: 60,
          keyboardType: selectInputType()),
    );
  }

  Widget title() => Container(
        alignment: Alignment.center,
        child: Text(
          widget.text!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding / 2),
            title(),
            textField(),
            addDataButton(context)
          ],
        ),
      ),
    );
  }
}
