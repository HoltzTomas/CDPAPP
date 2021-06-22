import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class FormScreenTitle extends StatelessWidget {
  /// Title for every screen of the app
  const FormScreenTitle({
    Key? key,
    @required this.text
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding * 2, left: defaultPadding),
      alignment: Alignment.centerLeft,
      child: Text(
        text!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
