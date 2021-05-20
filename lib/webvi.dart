import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVi extends StatefulWidget {
  @override
  _WebViState createState() => _WebViState();
}

class _WebViState extends State<WebVi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: 'https://excelitai.com/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,

      ),
    );
  }
}
