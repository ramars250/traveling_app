import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/schedule_model.dart';

class ScheduleNotifier extends StateNotifier<List<ScheduleModel>> {
  ScheduleNotifier() : super([]);

  void addSchedule(String startTime, String endTime, String location) {
    final schedule = ScheduleModel(
      startTime: startTime,
      endTime: endTime,
      location: location,
    );
    state = [...state, schedule];
  }
}
