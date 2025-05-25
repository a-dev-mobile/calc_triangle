import 'dart:math' as math;

import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/shared_components/triangle_visualization_widget.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AreaAndPerimeterWidget extends StatelessWidget {
  final RxString area;
  final RxString perimeter;
  final RxBool isActiveSnackBar;
  final TriangleVisualizationConfig Function() triangleConfigBuilder;

  const AreaAndPerimeterWidget({
    super.key,
    required this.area,
    required this.perimeter,
    required this.isActiveSnackBar,
    required this.triangleConfigBuilder,
  });

  void _showTriangleBottomSheet(BuildContext context, TriangleVisualizationConfig config) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent, // Убираем затемнение фона
      builder: (BuildContext context) {
        return SimpleTriangleBottomSheet(config: config);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !isActiveSnackBar.value,
        child: SizedBox(
          width: 1.sw,
          height: AppUtils.getHeight(context) * 0.06,
          child: Stack(
            children: <Widget>[
              // Area text - positioned more to the left
              Positioned(
                left: 15.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      TranslateHelper.area,
                      style: AppStyleText.titleText(context),
                    ),
                    Text(area.value, style: AppStyleText.subText(context)),
                  ],
                ),
              ),
              
              // Triangle - expanded area in the center with tap gesture
              Positioned(
                left: 80.w,
                right: 80.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Obx(() {
                    final config = triangleConfigBuilder();
                    
                    return GestureDetector(
                      onTap: () => _showTriangleBottomSheet(context, config),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: TriangleVisualizationWidget(
                          sideA: config.sideA,
                          sideB: config.sideB,
                          sideC: config.sideC,
                          angleA: config.angleA,
                          angleB: config.angleB,
                          angleC: config.angleC,
                          triangleType: config.triangleType,
                          isValid: config.isValid && !isActiveSnackBar.value,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              
              // Perimeter text - positioned more to the right
              Positioned(
                right: 15.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      TranslateHelper.perimeter,
                      style: AppStyleText.titleText(context),
                    ),
                    Text(
                      perimeter.value,
                      style: AppStyleText.subText(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SimpleTriangleBottomSheet extends StatelessWidget {
  final TriangleVisualizationConfig config;

  const SimpleTriangleBottomSheet({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          // Large triangle visualization
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.w),
              child: TriangleVisualizationWidget(
                sideA: config.sideA,
                sideB: config.sideB,
                sideC: config.sideC,
                angleA: config.angleA,
                angleB: config.angleB,
                angleC: config.angleC,
                triangleType: config.triangleType,
                isValid: config.isValid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 enum TriangleType { right, scalene, isosceles, equilateral }
class TriangleVisualizationConfig {
  final double? sideA;
  final double? sideB;
  final double? sideC;
  final double? angleA;
  final double? angleB;
  final double? angleC;
  final TriangleType triangleType;
  final bool isValid;

  const TriangleVisualizationConfig({
    this.sideA,
    this.sideB,
    this.sideC,
    this.angleA,
    this.angleB,
    this.angleC,
    required this.triangleType,
    required this.isValid,
  });
}

// Обновленный TriangleVisualizationWidget для лучшего использования пространства
class TriangleVisualizationWidget extends StatelessWidget {
  final double? sideA;
  final double? sideB;
  final double? sideC;
  final double? angleA;
  final double? angleB;
  final double? angleC;
  final bool isValid;
  final TriangleType triangleType;

  const TriangleVisualizationWidget({
    super.key,
    this.sideA,
    this.sideB,
    this.sideC,
    this.angleA,
    this.angleB,
    this.angleC,
    required this.isValid,
    required this.triangleType,
  });

  @override
  Widget build(BuildContext context) {
    if (!isValid || !_hasEnoughData()) {
      return Container(
        child: Icon(
          Icons.change_history_outlined,
          size: 30.sp,
          color: Colors.grey.withOpacity(0.5),
        ),
      );
    }

    return Container(
      child: CustomPaint(
        painter: ImprovedTrianglePainter(
          sideA: sideA,
          sideB: sideB,
          sideC: sideC,
          angleA: angleA,
          angleB: angleB,
          angleC: angleC,
          triangleType: triangleType,
          color: Theme.of(context).primaryColor,
        ),
        size: Size.infinite, // Используем все доступное пространство
      ),
    );
  }

  bool _hasEnoughData() {
    int sidesCount = [sideA, sideB, sideC].where((s) => s != null && s! > 0).length;
    int anglesCount = [angleA, angleB, angleC].where((a) => a != null && a! > 0).length;

    switch (triangleType) {
      case TriangleType.right:
        return sidesCount >= 1;
      case TriangleType.equilateral:
        return sidesCount >= 1;
      case TriangleType.isosceles:
        return sidesCount >= 2 || (sidesCount >= 1 && anglesCount >= 1);
      case TriangleType.scalene:
        return sidesCount >= 3 || (sidesCount >= 2 && anglesCount >= 1);
    }
  }
}

class ImprovedTrianglePainter extends CustomPainter {
  final double? sideA;
  final double? sideB;
  final double? sideC;
  final double? angleA;
  final double? angleB;
  final double? angleC;
  final TriangleType triangleType;
  final Color color;

  ImprovedTrianglePainter({
    this.sideA,
    this.sideB,
    this.sideC,
    this.angleA,
    this.angleB,
    this.angleC,
    required this.triangleType,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Рассчитываем вершины треугольника
    List<Offset> vertices = _calculateVertices();
    
    if (vertices.length != 3) {
      return;
    }

    // Масштабируем и центрируем треугольник
    vertices = _scaleAndCenterVertices(vertices, size);

    // Рисуем треугольник
    final path = Path()
      ..moveTo(vertices[0].dx, vertices[0].dy)
      ..lineTo(vertices[1].dx, vertices[1].dy)
      ..lineTo(vertices[2].dx, vertices[2].dy)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, strokePaint);


  }

  List<Offset> _calculateVertices() {
    switch (triangleType) {
      case TriangleType.right:
        return _calculateRightTriangleVertices();
      case TriangleType.equilateral:
        return _calculateEquilateralTriangleVertices();
      case TriangleType.isosceles:
        return _calculateIsoscelesTriangleVertices();
      case TriangleType.scalene:
        return _calculateScaleneTriangleVertices();
    }
  }

  List<Offset> _calculateRightTriangleVertices() {
    // В вашем коде: sideA = гипотенуза, sideB = катет A, sideC = катет B
    double hypotenuse = sideA ?? 0; // гипотенуза
    double cathetus1 = sideB ?? 0;  // катет 1
    double cathetus2 = sideC ?? 0;  // катет 2

    // Вычисляем недостающие стороны по теореме Пифагора
    if (hypotenuse > 0 && cathetus1 > 0 && cathetus2 <= 0) {
      cathetus2 = math.sqrt(math.max(0, hypotenuse * hypotenuse - cathetus1 * cathetus1));
    } else if (hypotenuse > 0 && cathetus2 > 0 && cathetus1 <= 0) {
      cathetus1 = math.sqrt(math.max(0, hypotenuse * hypotenuse - cathetus2 * cathetus2));
    } else if (cathetus1 > 0 && cathetus2 > 0 && hypotenuse <= 0) {
      hypotenuse = math.sqrt(cathetus1 * cathetus1 + cathetus2 * cathetus2);
    }

    if (cathetus1 <= 0 || cathetus2 <= 0) return [];

    // Стандартное расположение: прямой угол внизу слева
    return [
      Offset(0, cathetus2),          // Прямой угол (нижний левый)
      Offset(cathetus1, cathetus2),  // Нижний правый
      Offset(0, 0),                  // Верхний левый
    ];
  }

  List<Offset> _calculateEquilateralTriangleVertices() {
    double side = sideA ?? sideB ?? sideC ?? 1.0;
    
    if (side <= 0) return [];

    double height = side * math.sqrt(3) / 2;

    return [
      Offset(0, height),        // Левая нижняя вершина
      Offset(side, height),     // Правая нижняя вершина  
      Offset(side / 2, 0),      // Верхняя вершина
    ];
  }

  List<Offset> _calculateIsoscelesTriangleVertices() {
    double a = sideA ?? 0; // основание
    double b = sideB ?? 0; // равные стороны
    double c = sideC ?? 0; // равные стороны

    // Определяем, какие стороны равны
    if (b > 0 && c > 0 && (b - c).abs() < 0.001) {
      // b и c равны, a - основание
      if (a <= 0) a = b;
    } else if (a > 0 && c > 0 && (a - c).abs() < 0.001) {
      // a и c равны, b - основание
      double temp = a; a = b; b = temp;
    } else if (a > 0 && b > 0 && (a - b).abs() < 0.001) {
      // a и b равны, c - основание
      double temp = c; c = b; b = a; a = temp;
    } else {
      // Если не удается определить равные стороны, используем имеющиеся данные
      a = a > 0 ? a : 1.0;
      b = b > 0 ? b : 1.0;
    }

    if (a <= 0 || b <= 0) return [];

    double height = math.sqrt(math.max(0, b * b - (a * a) / 4));
    
    if (height.isNaN || height <= 0) {
      // Если не получается вычислить высоту, делаем простой треугольник
      height = b * 0.8;
    }

    return [
      Offset(0, height),        // Левая нижняя вершина
      Offset(a, height),        // Правая нижняя вершина
      Offset(a / 2, 0),         // Верхняя вершина
    ];
  }

  List<Offset> _calculateScaleneTriangleVertices() {
    double a = sideA ?? 0;
    double b = sideB ?? 0;
    double c = sideC ?? 0;

    if (a <= 0 || b <= 0 || c <= 0) return [];

    // Проверяем неравенство треугольника
    if (a + b <= c || a + c <= b || b + c <= a) {
      return [];
    }

    // Используем закон косинусов для вычисления углов
    double angleC = math.acos((a * a + b * b - c * c) / (2 * a * b));

    // Размещаем основание (сторону a) снизу, зеркально отражено по горизонтали
    double height = b * math.sin(angleC);
    double xPos = b * math.cos(angleC);
    
    return [
      Offset(0, height),        // Левая нижняя вершина (основание)
      Offset(a, height),        // Правая нижняя вершина
      Offset(a - xPos, 0)          // Верхняя вершина
    ];
  }

  List<Offset> _scaleAndCenterVertices(List<Offset> vertices, Size canvasSize) {
    if (vertices.isEmpty) return vertices;

    // Находим границы треугольника
    double minX = vertices.map((v) => v.dx).reduce(math.min);
    double maxX = vertices.map((v) => v.dx).reduce(math.max);
    double minY = vertices.map((v) => v.dy).reduce(math.min);
    double maxY = vertices.map((v) => v.dy).reduce(math.max);

    double width = maxX - minX;
    double height = maxY - minY;

    if (width == 0 || height == 0) return vertices;

    // Вычисляем масштаб с отступами
    double padding = 15;
    double scaleX = (canvasSize.width - padding * 2) / width;
    double scaleY = (canvasSize.height - padding * 2) / height;
    double scale = math.min(scaleX, scaleY);

    // Центрируем треугольник
    double centerX = canvasSize.width / 2;
    double centerY = canvasSize.height / 2;
    double triangleCenterX = minX + width / 2;
    double triangleCenterY = minY + height / 2;

    return vertices.map((vertex) {
      double x = (vertex.dx - triangleCenterX) * scale + centerX;
      double y = (vertex.dy - triangleCenterY) * scale + centerY;
      return Offset(x, y);
    }).toList();
  }

  

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}