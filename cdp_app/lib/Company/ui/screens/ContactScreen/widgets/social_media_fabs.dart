import 'package:cdp_app/Company/ui/screens/ContactScreen/widgets/social_media_icons.dart';
import 'package:cdp_app/Company/ui/screens/ContactScreen/widgets/web_view_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SocialMediaFABS extends StatelessWidget {
  ///Floating Action Buttons which redirects users to our social media accounts
  const SocialMediaFABS({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(flex: 2),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                child: const WebViewScreen(
                  url: "twitter.com/teamcdpapp",
                  appBarTitle: "Twitter",
                ),
                type: PageTransitionType.bottomToTop,
              ),
            );
          },
          heroTag: "Twitter Button",
          mini: true,
          backgroundColor: whiteColor,
          child: const Icon(SocialMediaIcons.twitter),
        ),
        const Spacer(),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                child: const WebViewScreen(
                  url: "instagram.com/cdp.app",
                  appBarTitle: "Instagram",
                ),
                type: PageTransitionType.bottomToTop,
              ),
            );
          },
          heroTag: "Instagram Button",
          backgroundColor: whiteColor,
          mini: true,
          child: const Icon(SocialMediaIcons.instagram),
        ),
        const Spacer(flex: 2)
      ],
    );
  }
}
