import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebInfoWidget extends StatefulWidget {
  const WebInfoWidget({Key? key}) : super(key: key);

  @override
  _WebInfoWidgetState createState() => _WebInfoWidgetState();
}

class _WebInfoWidgetState extends State<WebInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialFile: 'assets/form/formulas4-ru.html',
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          // supportZoom: false,
          javaScriptEnabled: true,
        ),
      ),
    );
  }
}
