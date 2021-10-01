import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:flutter/material.dart';

class TextTitleDetail extends StatelessWidget {
  const TextTitleDetail({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyleText.titleText(context),
    );
  }
}
