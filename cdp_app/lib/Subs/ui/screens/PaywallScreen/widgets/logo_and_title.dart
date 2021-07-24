import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/iconoTractor.svg",
              color: primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "CDP APP PRO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
        ),
      ],
    );
  }
}