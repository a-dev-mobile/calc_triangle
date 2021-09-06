import 'package:calc_triangle/app/ui/pages/right_triangle/widget/r_triangle_image_info_w.dart';
import 'package:calc_triangle/app/ui/widgets/formulas_web_view.dart';
import 'package:flutter/material.dart';

class RightTriangleInfoWidget extends StatefulWidget {
  const RightTriangleInfoWidget({Key? key}) : super(key: key);

  @override
  _RightTriangleInfoWidgetState createState() =>
      _RightTriangleInfoWidgetState();
}

class _RightTriangleInfoWidgetState extends State<RightTriangleInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: RightTriangleImageInfoWidget()),
            Expanded(child: WebInfoWidget()),
          ],
        ),
      ),
    );
  }
}
