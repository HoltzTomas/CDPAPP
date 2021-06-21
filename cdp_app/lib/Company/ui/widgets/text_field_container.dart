import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
