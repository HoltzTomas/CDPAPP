import 'package:cdp_app/Company/repository/company_cloud_repo.dart';
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final CompanyCloudRepo cloudRepo = CompanyCloudRepo();
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
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          child: const Text(
            "Tambien podes enviarnos un mail a teamcdpapp@gmail.com",
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
        ),
        const SizedBox(height: defaultPadding),
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
          text: isLoading ? "Cargando..." : "Enviar Comentario",
          press: () {
            if (!isLoading) {
              if (commentController.text.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                cloudRepo
                    .sendAnonymousComment(
                        comment: commentController.text, context: context)
                    .whenComplete(() {
                  setState(() {
                    isLoading = false;
                  });
                  commentController.clear();
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: primaryColor,
                    content: Text("No has escrito ningún comentario"),
                  ),
                );
              }
            }
          },
        )
      ],
    );
  }
}
