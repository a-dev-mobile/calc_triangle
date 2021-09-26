import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_size.dart';

import 'package:flutter/material.dart';

class DrawerIconWidget extends StatelessWidget {
  const DrawerIconWidget({
    Key? key,
    required GlobalKey<ScaffoldState> globalkey,
  })  : _globalkey = globalkey,
        super(key: key);

  final GlobalKey<ScaffoldState> _globalkey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _globalkey.currentState?.openDrawer();
        },
        icon: Icon(
          Icons.menu,
          size: AppSize.iconSize,
          color: AppColors.text(context),
        ));
  }
}
