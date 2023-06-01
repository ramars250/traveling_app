import 'package:flutter/material.dart';
import 'package:traveling_app/path_model.dart';

class SketchPainter extends CustomPainter {
  final List<PathModel> paths;

  //選中的路徑
  final int? selectedPathIndex;
  final List<List<Offset>> points;

  SketchPainter(
    this.paths,
    this.selectedPathIndex,
    this.points,
  );

  static final pen = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;

  static final selectedPen = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < paths.length; i++) {
      final pathModel = paths[i];
      final path = pathModel.path;
      final color = pathModel.color;
      if (i == selectedPathIndex) {
        canvas.drawPath(path, selectedPen);
        final Rect bounds = path.getBounds();
        // final Size size = bounds.size;
        final Paint rectPaint = Paint()
          ..color = Colors.grey.withOpacity(0.5)
          ..style = PaintingStyle.fill;
        canvas.drawRect(
            Rect.fromLTWH(
              bounds.left,
              bounds.top,
              bounds.width,
              bounds.height,
            ),
            rectPaint);
      } else {
        pen.color = color;
        canvas.drawPath(path, pen);
      }
    }
    for (final pathPoints in points) {
      final path = Path();
      if (pathPoints.isNotEmpty) {
        path.moveTo(pathPoints.first.dx, pathPoints.first.dy);
        for (int i = 1; i < pathPoints.length; i++) {
          path.lineTo(pathPoints[i].dx, pathPoints[i].dy);
        }
      }
      canvas.drawPath(path, pen);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
