import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          subtitle!,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
