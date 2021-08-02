import 'package:flutter/material.dart';

class ExampleImage extends StatelessWidget {
  const ExampleImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(9),
          border: Border.all()),
      child: Image.asset(
        imagePath,
        height: MediaQuery.of(context).size.height * 0.5,
      ),
    );
  }
}
