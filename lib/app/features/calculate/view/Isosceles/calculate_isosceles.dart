import 'package:flutter/material.dart';

import '2/isosceles__main_w.dart';

class CalculateIsoscelesPage extends StatefulWidget {
  const CalculateIsoscelesPage({super.key});

  @override
  _CalculateIsoscelesPageState createState() => _CalculateIsoscelesPageState();
}

class _CalculateIsoscelesPageState extends State<CalculateIsoscelesPage> {
  final bool _isBottomBannerAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: SafeArea(child: RightTriangleInputWidget()),
      body: SafeArea(child: IsoscelesMain()),
    );
  }
}
