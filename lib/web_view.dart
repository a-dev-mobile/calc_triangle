
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebVieww extends StatefulWidget {
  WebVieww({Key? key}) : super(key: key);

  @override
  _WebViewwState createState() => _WebViewwState();
}

class _WebViewwState extends State<WebVieww> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialFile: 'assets/form/formulas4-ru.html',
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          supportZoom: false,
          javaScriptEnabled: true,
          
          

        ),
      ),
    );
  }
}
