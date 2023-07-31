import 'package:calc_triangle/app/features/calculate/view/equilateral/2/equilateral_main_w.dart';

import 'package:flutter/material.dart';

class CalculateEquilateralPage extends StatefulWidget {
  const CalculateEquilateralPage({Key? key}) : super(key: key);

  @override
  _CalculateEquilateralPageState createState() =>
      _CalculateEquilateralPageState();
}

class _CalculateEquilateralPageState extends State<CalculateEquilateralPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: SafeArea(child: RightTriangleInputWidget()),
      body: SafeArea(child: EquilateralMain()),
    );
  }
}
