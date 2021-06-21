import 'package:cdp_app/Company/ui/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;

  const RoundedInputField({
    Key? key, this.hintText, this.icon, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(icon),
            hintText: hintText),
        controller: controller,
      ),
    );
  }
}
