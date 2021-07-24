import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class DescriptionTexts extends StatelessWidget {
  const DescriptionTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const[
        Text(
          "- Reutiliza datos",
        ),
        SizedBox(height: defaultPadding),
        Text(
          "- Emite cartas de porte ilimitadas",
        ),
      ],
    );
  }
}
