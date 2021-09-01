
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FormulasWebView extends StatefulWidget {
  const FormulasWebView({Key? key}) : super(key: key);

  @override
  _FormulasWebViewState createState() => _FormulasWebViewState();
}

class _FormulasWebViewState extends State<FormulasWebView> {
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
