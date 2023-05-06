class ScheduleModel {
  final String startTime;
  final String endTime;
  final String location;

  ScheduleModel(
      {required this.startTime, required this.endTime, required this.location});
}

class Schedule {
  List<ScheduleModel> scheduleList = [];

  void addList({
    required String startTime,
    required String endTime,
    required String location,
  }) {
    final schedules = ScheduleModel(
      startTime: startTime,
      endTime: endTime,
      location: location,
    );
    scheduleList.add(schedules);
  }
  final schedule = Schedule();
}

