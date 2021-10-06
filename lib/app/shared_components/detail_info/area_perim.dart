
import 'package:calc_triangle/app/shared_components/detail_info/detail_item.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:flutter/material.dart';

class AreaPerimeter extends StatelessWidget {
  const AreaPerimeter({
    Key? key, required this.perimeter, required this.area,
  }) : super(key: key);
 final String perimeter;
 final String area;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        ItemDetail(
          isActive: false,
          leading: 'P',
          subtitle: TranslateHelper.perimeter,
          title: perimeter,
        ), ItemDetail(
          isActive: false,
          leading: 'A',
          subtitle: TranslateHelper.area,
          title: area,
        ),
      ],
    );
  }
}
