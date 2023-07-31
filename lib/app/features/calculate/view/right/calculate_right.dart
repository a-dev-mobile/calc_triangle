import 'package:calc_triangle/app/features/calculate/view/right/2/right_main_w.dart';

import 'package:flutter/material.dart';

class CalculateRightPage extends StatefulWidget {
  const CalculateRightPage({Key? key}) : super(key: key);

  @override
  _CalculateRightPageState createState() => _CalculateRightPageState();
}

class _CalculateRightPageState extends State<CalculateRightPage> {
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
      body: SafeArea(child: RightMain()),
    );
  }
}
