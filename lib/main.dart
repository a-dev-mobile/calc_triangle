// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 960),
        builder: () {
          return MaterialApp(
            home: HomePage(),
          );
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        color: Colors.blue,
        child: Column(
          
          children: [
            Expanded(
              child: Container(
                color: Colors.amber,
                child: Image(
                  image: AssetImage('assets/k4b.webp'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.amber,
                child: Image(
                  image: AssetImage('assets/k4b.webp'),
                ),
              ),
            ),
            Expanded(
              child: Container(color: Colors.blueGrey, child: WebVieww()),
            ),
          ],
        ),
      ),
    );
  }
}

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



// class WebViewExample extends StatefulWidget {
//   @override
//   WebViewExampleState createState() => WebViewExampleState();
// }

// class WebViewExampleState extends State<WebViewExample> {
//   WebViewController? _controller;
//   @override
//   void initState() {
//     super.initState();
//     // Enable hybrid composition.
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'about:blank',
//       javascriptMode: JavascriptMode.unrestricted,
      
//       onWebViewCreated: (WebViewController webViewController) {
//         _controller = webViewController;
//         webViewController.evaluateJavascript(         'alert("hello from flutter")');
//           _loadHtmlFromAssets();
//       },
      
//     );
//   }
//    _loadHtmlFromAssets() async {
//     String fileText = await rootBundle.loadString('assets/form/formulas4-ru.html');


//     _controller?.loadUrl( Uri.dataFromString(
//         fileText,
//         mimeType: 'text/html',
//         encoding: Encoding.getByName('utf-8')
//     ).toString());
//   }
// }
