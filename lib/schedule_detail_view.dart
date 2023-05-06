import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/provider.dart';

class ScheduleDetailView extends StatefulWidget {
  const ScheduleDetailView({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailView> createState() => _ScheduleDetailViewState();
}

class _ScheduleDetailViewState extends State<ScheduleDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, child) {
        final detailData = ref.watch(scheduleProvider);
        return Container(
          color: Colors.blue,
          child: Text('${detailData.length}'),
        );
      })
    );
  }
}
