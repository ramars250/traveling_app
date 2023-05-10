// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/provider.dart';

class ScheduleDetailView extends StatefulWidget {
  const ScheduleDetailView({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailView> createState() => _ScheduleDetailViewState();
}

class _ScheduleDetailViewState extends State<ScheduleDetailView> {

  final PaintedBoardProvider _paintedBoardProvider = PaintedBoardProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: GestureDetector(
            onPanStart: (details) {
              _paintedBoardProvider.onStart(details);
            },
            onPanUpdate: (details) {
              _paintedBoardProvider.onUpdate(details);
            },
            onPanEnd: (details) {
              print('移動結束');
            },
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
              painter: MyPainter(_paintedBoardProvider),
            ),
          ),
        ));
  }
}

class MyPainter extends CustomPainter {

  MyPainter(this.paintedBoardProvider) : super(repaint: paintedBoardProvider);
  final PaintedBoardProvider paintedBoardProvider;

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in paintedBoardProvider.strokes) {
      final paint = Paint()
          ..strokeWidth = stroke.width
          ..color = stroke.color
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
      canvas.drawPath(stroke.path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Stroke {
  final path = Path();
  Color color;
  double width;

  Stroke({
    this.color = Colors.black,
    this.width = 3,
  });
}

class PaintedBoardProvider extends ChangeNotifier {

  final List<Stroke> _strokes = [];
  List<Stroke> get strokes => _strokes;

  var color = Colors.greenAccent;
  double paintWidth = 3;

  void onStart(DragStartDetails details) {
    double startX = details.localPosition.dx;
    double startY = details.localPosition.dy;
    final newStroke = Stroke(
      color: color,
      width: paintWidth,
    );
    newStroke.path.moveTo(startX, startY);
    _strokes.add(newStroke);
  }

  void onUpdate(DragUpdateDetails details) {
    _strokes.last.path.lineTo(details.localPosition.dx, details.localPosition.dy);
    notifyListeners();
  }
}
