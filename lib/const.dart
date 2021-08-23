import 'dart:ui';

abstract class AssetsPathTriangle {
  static const String _pathAssetsImage = 'assets/image/triangle/';

  static const String scalene = 'Scalene Triangle';
  static const String equilateral = 'Equilateral Triangle';
  static const String isosceles = 'Isosceles Triangle';
  static const String right = 'Right Triangle';

  static const Map<String, String> imagePathsTriangle = {
    scalene: '$_pathAssetsImage/1.webp',
    isosceles: '$_pathAssetsImage/2.webp',
    equilateral: 'assets/image/triangle/3.webp',
    right: 'assets/image/triangle/4.webp',
  };
}

enum Triangle {
  scalene,
  isosceles,
  equilateral,
  right,
}

enum BtnTypeCalc { integer, function, operator }


abstract class ConstColors{
   static const scaffoldBackground = Color.fromRGBO(72, 72, 72, 1);

}