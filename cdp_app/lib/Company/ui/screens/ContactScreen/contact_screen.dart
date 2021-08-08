import 'package:cdp_app/Company/ui/screens/ContactScreen/widgets/feedback_box.dart';
import 'package:cdp_app/Company/ui/screens/ContactScreen/widgets/social_media_fabs.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text("Contacto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: defaultPadding),
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 45,
                  child: Image.asset("assets/icons/app_icon.png"),
                ),
              ),
              const SizedBox(height: defaultPadding),
              const SocialMediaFABS(),
              const SizedBox(height: defaultPadding * 2),
              const FeedbackBox()
            ],
          ),
        ),
      ),
    );
  }
}



