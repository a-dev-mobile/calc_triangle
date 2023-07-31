import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.isActive,
  }) : super(key: key);
  final String leading;
  final String title;
  final String subtitle;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    TextStyle styleLeading;
    TextStyle styleTitle;

    if (isActive) {
      styleLeading = AppStyleText.leadingTextDetail(context);
      styleTitle = AppStyleTextImage.activeParam(context);
    } else {
      styleLeading = AppStyleText.leadingTextDetail(context);
      styleTitle = AppStyleTextImage.inActive(context);
    }

    return ListTile(
      leading: Text(leading, style: styleLeading),
      title: Text(title, style: styleTitle),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.text(context).withOpacity(0.5)),
      ),
    );
  }
}
