import 'package:cdp_app/Company/ui/widgets/rounded_button.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class FeedbackBox extends StatefulWidget {
  const FeedbackBox({
    Key? key,
  }) : super(key: key);

  @override
  _FeedbackBoxState createState() => _FeedbackBoxState();
}

class _FeedbackBoxState extends State<FeedbackBox> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: const Text(
            "Dejanos tu opinion de manera anonima",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        const SizedBox(height: defaultPadding * 1.5),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteColor,
              boxShadow: const [BoxShadow(blurRadius: 10)]),
          child: TextField(
            maxLines: 10,
            controller: commentController,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        const SizedBox(height: defaultPadding),
        RoundedButton(
          text: "Enviar Comentario",
          press: () {
            if (commentController.text.isNotEmpty) {
              commentController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: primaryColor,
                  content: Text("Comentario enviado con exito!!"),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: primaryColor,
                  content: Text("No has escrito ningún comentario"),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
