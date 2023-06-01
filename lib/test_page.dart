import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/painter.dart';
import 'package:traveling_app/provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testProvider = ref.watch(scheduleDetailViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          foregroundPainter: SketchPainter(
              testProvider.paths,
              null,
              testProvider.pointsList),
          child: Container(
            color: Colors.yellow[100],
          ),
        ),
      ),
    );
  }
}
