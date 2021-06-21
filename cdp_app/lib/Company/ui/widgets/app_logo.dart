import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SvgPicture.asset(
      'assets/icons/iconoTractor.svg',
      height: size.height * 0.3,
      color: primaryColor,
    );
  }
}