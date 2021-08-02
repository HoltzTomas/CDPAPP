import 'package:cdp_app/Company/ui/screens/HowToUseScreen/widgets/example_image.dart';
import 'package:cdp_app/Company/ui/screens/HowToUseScreen/widgets/title_and_subtitle.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class UploadFileExample extends StatelessWidget {
  const UploadFileExample({Key? key}) : super(key: key);

  PageViewModel pageModel({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imagePath,
  }) =>
      PageViewModel(
        titleWidget: TitleAndSubtitle(
          title: title,
          subtitle: subtitle,
        ),
        bodyWidget: ExampleImage(imagePath: imagePath),
      );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showDoneButton: false,
      showNextButton: false,
      dotsDecorator: const DotsDecorator(activeColor: primaryColor),
      pages: [
        pageModel(
          context: context,
          title: "Paso 1",
          subtitle:
              "Subir archivo, tocando el botón verde de la parte inferior.",
          imagePath: "assets/images/how_to_use_one.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 2",
          subtitle:
              "Seleccionar el archivo que contiene las cartas de porte.",
          imagePath: "assets/images/how_to_use_two.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 3",
          subtitle:
              "Ponerle nombre al archivo, por ejemplo 'Primer Archivo', y subirlo.",
          imagePath: "assets/images/how_to_use_three.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 4",
          subtitle: "Seleccionar el archivo desde el que quearemos emitir una carta de porte.",
          imagePath: "assets/images/how_to_use_four.jpg",
        ),
      ],
    );
  }
}
