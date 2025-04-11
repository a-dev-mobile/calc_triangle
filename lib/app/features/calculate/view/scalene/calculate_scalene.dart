import 'package:calc_triangle/app/features/calculate/view/scalene/2/scalene_main_w.dart';

import 'package:flutter/material.dart';

class CalculateScalenePage extends StatefulWidget {
  const CalculateScalenePage({super.key});

  @override
  _CalculateScalenePageState createState() => _CalculateScalenePageState();
}

class _CalculateScalenePageState extends State<CalculateScalenePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ScaleneMain()));
  }
}
