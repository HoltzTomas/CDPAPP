import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  ///Used in [FormScreen] to collect data
  const FormTextField(
      {Key? key,
      @required this.dataWeWantReceive,
      this.controller,
      this.onChanged,
      this.keyboardType})
      : super(key: key);

  final String? dataWeWantReceive;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      child: Form(
        child: TextFormField(
          maxLines: null,
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: primaryColor,
          style: const TextStyle(
            color: darkColor,
          ),
          decoration: InputDecoration(
            labelText: dataWeWantReceive,
            labelStyle: const TextStyle(
              color: darkColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              decoration: TextDecoration.underline
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}