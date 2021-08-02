import 'package:cdp_app/Company/ui/screens/HowToUseScreen/widgets/example_image.dart';
import 'package:cdp_app/Company/ui/screens/HowToUseScreen/widgets/title_and_subtitle.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IssueCDPExample extends StatelessWidget {
  const IssueCDPExample({Key? key}) : super(key: key);

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
          title: "Paso 5",
          subtitle: "Emite una nueva carta de porte utilizando el boton de la parte inferior.",
          imagePath: "assets/images/how_to_use_five.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 6",
          subtitle: "En cada campo, agregar datos para que puedan ser reutilizados.",
          imagePath: "assets/images/how_to_use_six.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 7",
          subtitle: "En cada campo, seleccionar el dato a usar en esta carta de porte.",
          imagePath: "assets/images/how_to_use_seven.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 8",
          subtitle: "Ponerle nombre a la carta de porte y emitirla.",
          imagePath: "assets/images/how_to_use_eight.jpg",
        ),
        pageModel(
          context: context,
          title: "Paso 9",
          subtitle: "Una vez emitida, podras editarla, visualizarla o copiarla para emitir una nueva con esos datos.",
          imagePath: "assets/images/how_to_use_nine.jpg",
        ),
      ],
    );
  }
}
