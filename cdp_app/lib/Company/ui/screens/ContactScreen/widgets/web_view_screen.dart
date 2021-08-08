import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({
    Key? key,
    required this.url,
    required this.appBarTitle,
  }) : super(key: key);

  final String url;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        backgroundColor: whiteColor,
      ),
      url: url,
    );
  }
}
