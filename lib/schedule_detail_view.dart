// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/painter.dart';
import 'package:traveling_app/palette.dart';
import 'package:traveling_app/provider.dart';
import 'package:traveling_app/test_page.dart';

class ScheduleDetailView1 extends ConsumerWidget {
  const ScheduleDetailView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleDetail = ref.watch(scheduleDetailViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.yellow[200],
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {},
                    child: const Icon(Icons.save),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.undo,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showColorPickerDialog(context, (Color selectedColor) {
                        scheduleDetail.selectedColor = selectedColor;
                      });
                    },
                    icon: const Icon(
                      Icons.palette,
                      color: Colors.orange,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TestPage()));
                    },
                    child: const Icon(Icons.move_down),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.yellow[100],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanDown: scheduleDetail.handlePanDown,
                      onPanUpdate: scheduleDetail.handlePanUpdate,
                      onPanEnd: (_) => scheduleDetail.handlePanEnd(),
                      child: CustomPaint(
                        painter: SketchPainter(
                          scheduleDetail.paths,
                          scheduleDetail.selectedPathIndex,
                          scheduleDetail.pointsList,
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scheduleDetail.toggleMovingMode,
        child: scheduleDetail.isMoving
            ? const Icon(Icons.touch_app)
            : const Icon(Icons.edit),
      ),
    );
  }
}

// class ScheduleDetailView extends ConsumerStatefulWidget {
//   const ScheduleDetailView({Key? key}) : super(key: key);
//
//   @override
//   _ScheduleDetailViewState createState() => _ScheduleDetailViewState();
// }
//
// class _ScheduleDetailViewState extends ConsumerState<ScheduleDetailView> {
//   final List<Path> paths = [];
//   int points = 0;
//   Path? _current;
//
//   //判斷模式
//   bool isMoving = false;
//
//   //標記畫板的KEY，用於截圖
//   GlobalKey imageKey = GlobalKey();
//
//   //截圖的本地保存路徑
//   String imageLocalPath = '';
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedPathIndex = ref.watch(selectedPathProvider);
//     final documentId = ref.watch(documentIdProvider);
//     // final sketch = ref.watch(sketchProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.white,
//               child: Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {},
//                     child: const Icon(Icons.save),
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: const Icon(Icons.move_down),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: RepaintBoundary(
//                   key: imageKey,
//                   child: Stack(
//                     children: [
//                       GestureDetector(
//                         onPanDown: (details) {
//                           if (!isMoving) {
//                             setState(() {
//                               _current = Path();
//                               paths.add(_current!);
//                               _current!.moveTo(
//                                 details.localPosition.dx,
//                                 details.localPosition.dy,
//                               );
//                               _current!.lineTo(
//                                 details.localPosition.dx + 1,
//                                 details.localPosition.dy + 1,
//                               );
//                             });
//                           } else {
//                             setState(() {
//                               ref.read(selectedPathProvider.notifier).state =
//                                   null;
//                               for (int i = paths.length - 1; i >= 0; i--) {
//                                 Path path = paths[i];
//                                 if (path
//                                     .getBounds()
//                                     .inflate(20.0)
//                                     .contains(details.localPosition)) {
//                                   ref
//                                       .read(selectedPathProvider.notifier)
//                                       .state = i;
//                                   break;
//                                 }
//                               }
//                             });
//                           }
//                         },
//                         onPanUpdate: (details) {
//                           if (isMoving && selectedPathIndex != null) {
//                             setState(() {
//                               paths[selectedPathIndex] =
//                                   paths[selectedPathIndex].shift(Offset(
//                                       details.delta.dx, details.delta.dy));
//                             });
//                           } else {
//                             points++;
//                             setState(() {
//                               _current!.lineTo(
//                                 details.localPosition.dx,
//                                 details.localPosition.dy,
//                               );
//                             });
//                           }
//                         },
//                         onPanEnd: (_) {
//                           String testPath = _current.toString();
//                           FireCrud.updateSchedule(documentId, testPath);
//                           _current = null;
//                         },
//                         // onPanEnd: (_) => _current = null,
//                         child: CustomPaint(
//                           foregroundPainter:
//                               SketchPainter(paths, selectedPathIndex),
//                           child: Container(color: Colors.yellow[100]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // FireCrud.updateSchedule(documentId, paths);
//           setState(() {
//             isMoving = !isMoving;
//             if (!isMoving && selectedPathIndex != null) {
//               ref.read(selectedPathProvider.notifier).state = null;
//             }
//           });
//         },
//         child: isMoving ? const Icon(Icons.touch_app) : const Icon(Icons.edit),
//       ),
//     );
//   }
// }
