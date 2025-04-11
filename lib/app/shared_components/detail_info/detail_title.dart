import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:flutter/material.dart';

class TextTitleDetail extends StatelessWidget {
  const TextTitleDetail({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: AppStyleText.titleText(context)),
    );
  }
}
