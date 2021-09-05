import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:flutter/material.dart';

import 'right_triangle_info_w.dart';
import 'right_triangle_input_w.dart';

class RightTrianglePage extends StatefulWidget {
  const RightTrianglePage({Key? key}) : super(key: key);

  @override
  _RightTrianglePageState createState() => _RightTrianglePageState();
}

class _RightTrianglePageState extends State<RightTrianglePage> {
  final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalkey,
      body: SafeArea(
        child: Stack(
          children: [
            DrawerIconWidget(globalkey: _globalkey),
            PageView(
              // physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [RightTriangleInputWidget(), RightTriangleInfoWidget()],
            )
          ],
        ),
      ),
    );
  }
}
