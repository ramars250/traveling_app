// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/painter.dart';
import 'package:traveling_app/provider.dart';

class ScheduleDetailView extends StatefulWidget {
  const ScheduleDetailView({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailView> createState() => _ScheduleDetailViewState();
}

class _ScheduleDetailViewState extends State<ScheduleDetailView> {
  final List<Path> paths = [];
  int _points = 0;
  Path? _current;
  //判斷模式
  bool isMoving = false;
  //選中路徑
  int? selectedPathIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanDown: (details) {
              if (!isMoving) {
                setState(() {
                  _current = Path();
                  paths.add(_current!);
                  _current!.moveTo(
                    details.localPosition.dx,
                    details.localPosition.dy,
                  );
                  _current!.lineTo(
                    details.localPosition.dx + 1,
                    details.localPosition.dy + 1,
                  );
                });
              } else {
                setState(() {
                  selectedPathIndex = null;
                  for (int i = paths.length - 1; i >= 0; i--) {
                    Path path = paths[i];
                    if (path
                        .getBounds()
                        .inflate(20.0)
                        .contains(details.localPosition)) {
                      // if (paths[i].contains(details.localPosition)) {
                      selectedPathIndex = i;
                      break;
                    }
                  }
                });
              }
            },
            onPanUpdate: (details) {
              if (isMoving && selectedPathIndex != null) {
                setState(() {
                  paths[selectedPathIndex!] = paths[selectedPathIndex!]
                      .shift(Offset(details.delta.dx, details.delta.dy));
                });
              } else {
                _points++;
                setState(() {
                  _current!.lineTo(
                    details.localPosition.dx,
                    details.localPosition.dy,
                  );
                });
              }
            },
            onPanEnd: (_) => _current = null,
            child: CustomPaint(
              foregroundPainter: SketchPainter(paths, selectedPathIndex),
              child: Container(color: Colors.yellow[100]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isMoving = !isMoving;
            if (!isMoving && selectedPathIndex != null) {
              selectedPathIndex = null;
            }
          });
        },
        child: isMoving ? const Icon(Icons.touch_app) : const Icon(Icons.edit),
      ),
    );
  }
}

// // ignore_for_file: avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:traveling_app/provider.dart';
//
// class ScheduleDetailView extends StatefulWidget {
//   const ScheduleDetailView({Key? key}) : super(key: key);
//
//   @override
//   State<ScheduleDetailView> createState() => _ScheduleDetailViewState();
// }
//
// class _ScheduleDetailViewState extends State<ScheduleDetailView> {
//   final PaintedBoardProvider _paintedBoardProvider = PaintedBoardProvider();
//   Offset _currentPosition = Offset.zero;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Test'),
//           centerTitle: true,
//         ),
//         body: Container(
//           color: Colors.white,
//           child: GestureDetector(
//             onPanStart: (details) {
//               _paintedBoardProvider.onStart(details);
//               _currentPosition = details.localPosition;
//             },
//             onPanUpdate: (details) {
//               _paintedBoardProvider
//                   .onUpdateWithOffset(details.localPosition - _currentPosition);
//               _currentPosition = details.localPosition;
//               _paintedBoardProvider.onUpdate(details);
//             },
//             onPanEnd: (details) {
//               print('移動結束');
//             },
//             child: CustomPaint(
//               size: Size(MediaQuery.of(context).size.width,
//                   MediaQuery.of(context).size.height),
//               painter: MyPainter(_paintedBoardProvider),
//             ),
//           ),
//         ));
//   }
// }
//
// class MyPainter extends CustomPainter {
//   MyPainter(this.paintedBoardProvider) : super(repaint: paintedBoardProvider);
//   final PaintedBoardProvider paintedBoardProvider;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (final stroke in paintedBoardProvider.strokes) {
//       final paint = Paint()
//         ..strokeWidth = stroke.width
//         ..color = stroke.color
//         ..strokeCap = StrokeCap.round
//         ..style = PaintingStyle.stroke;
//       canvas.drawPath(stroke.path, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class Stroke {
//   Path path = Path();
//   Color color;
//   double width;
//   final List<Offset> _points;
//
//   Stroke({
//     this.color = Colors.black,
//     this.width = 3,
//   }) : _points = [];
//
//   void moveTo(double x, double y) {
//     path.moveTo(x, y);
//     _points.add(Offset(x, y));
//   }
//
//   void lineTo(double x, double y) {
//     path.lineTo(x, y);
//     _points.add(Offset(x, y));
//   }
//
//   List<Offset> get points => List.unmodifiable(_points);
// }
//
// class PaintedBoardProvider extends ChangeNotifier {
//   final List<Stroke> _strokes = [];
//   late Offset _lastOffset;
//   late Stroke _selectedStroke;
//
//   List<Stroke> get strokes => _strokes;
//
//   var color = Colors.greenAccent;
//   double paintWidth = 3;
//
//   void onStart(DragStartDetails details) {
//     _lastOffset = details.localPosition;
//     bool foundSelectedStroke = false;
//     for (int i= _strokes.length -1 ; i >= 0; i--) {
//       if (_strokes[1].path.contains(_lastOffset)) {
//         _selectedStroke = _strokes[i];
//         _strokes.removeAt(i);
//         _strokes.add(_selectedStroke);
//         foundSelectedStroke = true;
//         break;
//       }
//     }
//     if (!foundSelectedStroke) {
//       final newStroke = Stroke(
//         color: color,
//         width: paintWidth,
//       );
//       newStroke.path.moveTo(_lastOffset.dx, _l);
//       _strokes.add(newStroke);
//     }
//     double startX = details.localPosition.dx;
//     double startY = details.localPosition.dy;
//
//
//   }
//
//   void onUpdate(DragUpdateDetails details) {
//     _strokes.last.lineTo(details.localPosition.dx, details.localPosition.dy);
//
//     // _strokes.last.path.lineTo(details.localPosition.dx, details.localPosition.dy);
//     notifyListeners();
//   }
//
//   void onUpdateWithOffset(Offset offset) {
//     for (final stroke in _strokes) {
//       stroke.path = stroke.path.shift(offset);
//       for (final point in stroke.points) {
//         point.translate(offset.dx, offset.dy);
//       }
//     }
//     notifyListeners();
//   }
// }

// class ScheduleDetailView1 extends StatefulWidget {
//   const ScheduleDetailView1({Key? key}) : super(key: key);
//
//   @override
//   State<ScheduleDetailView1> createState() => _ScheduleDetailView1State();
// }
//
// class _ScheduleDetailView1State extends State<ScheduleDetailView1> {
//   final PaintedBoardProvider _paintedBoardProvider = PaintedBoardProvider();
//   bool _isDrawing = true;
//   Offset _offset = Offset.zero;
//   int _selectedStrokeIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test'),
//         centerTitle: true,
//       ),
//       body: Container(
//         color: Colors.white,
//         child: GestureDetector(
//           onPanStart: (details) {
//             _isDrawing ? _paintedBoardProvider.onStart(details) : null;
//           },
//           onPanUpdate: (details) {
//             _isDrawing ? _paintedBoardProvider.onUpdate(details) : null;
//           },
//           onPanEnd: (details) {
//             _isDrawing ? print('繪製圖形中') : print('移動圖形中');
//           },
//           child: CustomPaint(
//             size: Size(MediaQuery.of(context).size.width,
//                 MediaQuery.of(context).size.height),
//             painter: SketchPainter(),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _isDrawing = !_isDrawing;
//             _paintedBoardProvider.toggleMode();
//           });
//         },
//         child: Icon(_isDrawing ? Icons.select_all : Icons.edit),
//       ),
//     );
//   }
// }