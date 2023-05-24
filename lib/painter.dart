import 'package:flutter/material.dart';

class SketchPainter extends CustomPainter {
  final List<Path> paths;

  //選中的路徑
  final int? selectedPathIndex;

  SketchPainter(this.paths, this.selectedPathIndex);

  static final pen = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;

  static final selectedPen = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < paths.length; i++) {
      if (i == selectedPathIndex) {
        canvas.drawPath(paths[i], selectedPen);
        final Rect bounds = paths[i].getBounds();
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
        canvas.drawPath(paths[i], pen);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
