import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TriangleType { right, scalene, isosceles, equilateral }

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
    // Отладочная информация
    debugPrint('=== Triangle Visualization Debug ===');
    debugPrint('Type: $triangleType');
    debugPrint('Valid: $isValid');
    debugPrint('Sides: A=$sideA, B=$sideB, C=$sideC');
    debugPrint('Angles: A=$angleA, B=$angleB, C=$angleC');
    
    if (!isValid || !_hasEnoughData()) {
      debugPrint('Triangle not valid or insufficient data');
      return Container(
        width: 100.w,
        height: 100.w,
        child: Icon(
          Icons.change_history_outlined,
          size: 40.sp,
          color: Colors.grey.withOpacity(0.5),
        ),
      );
    }

    return Container(
      width: 100.w,
      height: 100.w,
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
      ),
    );
  }

  bool _hasEnoughData() {
    int sidesCount = [sideA, sideB, sideC].where((s) => s != null && s! > 0).length;
    int anglesCount = [angleA, angleB, angleC].where((a) => a != null && a! > 0).length;

    switch (triangleType) {
      case TriangleType.right:
        // Для прямоугольного треугольника нужно минимум 2 стороны
        return sidesCount >= 2;
        
      case TriangleType.equilateral:
        // Для равностороннего треугольника нужна хотя бы одна сторона
        return sidesCount >= 1;
        
      case TriangleType.isosceles:
        // Для равнобедренного треугольника нужно минимум 2 стороны или 1 сторона + 1 угол
        return sidesCount >= 2 || (sidesCount >= 1 && anglesCount >= 1);
        
      case TriangleType.scalene:
        // Для разностороннего треугольника нужно 3 стороны или комбинация сторон и углов
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
      debugPrint('Failed to calculate triangle vertices');
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

    // Рисуем маркер прямого угла для прямоугольного треугольника
    if (triangleType == TriangleType.right) {
      _drawRightAngleMarker(canvas, vertices, strokePaint);
    }
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
    double a = sideA ?? 0; // гипотенуза (противолежит углу A = 90°)
    double b = sideB ?? 0; // катет B
    double c = sideC ?? 0; // катет C

    // Вычисляем недостающие стороны по теореме Пифагора
    if (a > 0 && b > 0 && c <= 0) {
      c = math.sqrt(a * a - b * b);
    } else if (a > 0 && c > 0 && b <= 0) {
      b = math.sqrt(a * a - c * c);
    } else if (b > 0 && c > 0 && a <= 0) {
      a = math.sqrt(b * b + c * c);
    }

    if (b <= 0 || c <= 0) return [];

    // Размещаем треугольник: прямой угол внизу справа, основание (гипотенуза) внизу
    // Зеркально отражаем по горизонтали
    return [
      Offset(c, b),      // Прямой угол внизу справа (угол A = 90°)
      Offset(0, b),      // Левый нижний угол (конец гипотенузы)
      Offset(c, 0),      // Верхняя вершина
    ];
  }

  List<Offset> _calculateEquilateralTriangleVertices() {
    double side = sideA ?? sideB ?? sideC ?? 1.0;
    
    if (side <= 0) return [];

    double height = side * math.sqrt(3) / 2;

    // Основание снизу, вершина сверху, зеркально отражено по горизонтали
    return [
      Offset(side, height),     // Правая нижняя вершина
      Offset(0, height),        // Левая нижняя вершина  
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
      if (a <= 0) a = b; // если основание не задано, делаем равносторонний
    } else if (a > 0 && c > 0 && (a - c).abs() < 0.001) {
      // a и c равны, b - основание
      double temp = a; a = b; b = temp; // переставляем
    } else if (a > 0 && b > 0 && (a - b).abs() < 0.001) {
      // a и b равны, c - основание
      double temp = c; c = b; b = a; a = temp; // переставляем
    } else {
      // Если не удается определить равные стороны, используем имеющиеся данные
      a = a > 0 ? a : 1.0;
      b = b > 0 ? b : 1.0;
    }

    if (a <= 0 || b <= 0) return [];

    // Вычисляем высоту равнобедренного треугольника
    double height = math.sqrt(b * b - (a * a) / 4);
    
    if (height.isNaN || height <= 0) {
      // Если не получается вычислить высоту, делаем простой треугольник
      height = b * 0.8;
    }

    // Основание снизу, вершина сверху, зеркально отражено по горизонтали
    return [
      Offset(a, height),        // Правая нижняя вершина
      Offset(0, height),        // Левая нижняя вершина
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
      debugPrint('Triangle inequality violation: $a, $b, $c');
      return [];
    }

    // Используем закон косинусов для вычисления углов
    double angleC = math.acos((a * a + b * b - c * c) / (2 * a * b));

    // Размещаем основание (сторону a) снизу, зеркально отражено по горизонтали
    double height = b * math.sin(angleC);
    double xPos = b * math.cos(angleC);
    
    return [
      Offset(a, height),                              // Правая нижняя вершина
      Offset(0, height),                              // Левая нижняя вершина (основание)
      Offset(a - xPos, 0),                           // Верхняя вершина (зеркально отражена)
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

  void _drawRightAngleMarker(Canvas canvas, List<Offset> vertices, Paint paint) {
    if (vertices.length != 3) return;

    // Для прямоугольного треугольника прямой угол теперь в первой вершине (внизу справа)
    Offset rightAngleVertex = vertices[0];
    Offset vertex2 = vertices[1];
    Offset vertex3 = vertices[2];

    // Размер маркера прямого угла
    double markerSize = 12.0;

    // Вычисляем направления от прямого угла к другим вершинам
    Offset dir1 = Offset(
      (vertex2.dx - rightAngleVertex.dx),
      (vertex2.dy - rightAngleVertex.dy),
    );
    Offset dir2 = Offset(
      (vertex3.dx - rightAngleVertex.dx),
      (vertex3.dy - rightAngleVertex.dy),
    );

    // Нормализуем направления
    double len1 = math.sqrt(dir1.dx * dir1.dx + dir1.dy * dir1.dy);
    double len2 = math.sqrt(dir2.dx * dir2.dx + dir2.dy * dir2.dy);

    if (len1 == 0 || len2 == 0) return;

    dir1 = Offset(dir1.dx / len1 * markerSize, dir1.dy / len1 * markerSize);
    dir2 = Offset(dir2.dx / len2 * markerSize, dir2.dy / len2 * markerSize);

    // Рисуем квадратик для обозначения прямого угла
    final markerPath = Path()
      ..moveTo(rightAngleVertex.dx + dir1.dx, rightAngleVertex.dy + dir1.dy)
      ..lineTo(rightAngleVertex.dx + dir1.dx + dir2.dx, rightAngleVertex.dy + dir1.dy + dir2.dy)
      ..lineTo(rightAngleVertex.dx + dir2.dx, rightAngleVertex.dy + dir2.dy);

    canvas.drawPath(markerPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}