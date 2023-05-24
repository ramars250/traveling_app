import 'dart:ui';

class ScheduleDetailModel {
  final List<Path> paths;
  final int points;
  final Path? current;
  final bool isMoving;
  final int? selectedPathIndex;
  final String? documentId;

  ScheduleDetailModel({
    required this.paths,
    required this.points,
    required this.current,
    required this.isMoving,
    required this.selectedPathIndex,
    required this.documentId,
  });
  ScheduleDetailModel copyWith({
    List<Path>? paths,
    int? points,
    Path? current,
    bool? isMoving,
    int? selectedPathIndex,
    String? documentId,
  }) {
    return ScheduleDetailModel(
      paths: paths ?? this.paths,
      points: points ?? this.points,
      current: current ?? this.current,
      isMoving: isMoving ?? this.isMoving,
      selectedPathIndex: selectedPathIndex ?? this.selectedPathIndex,
      documentId: documentId ?? this.documentId,
    );
  }
  // final List<Path> paths;
  // bool isMoving;
  // int points;
  // late Path? current;
  //
  // ScheduleDetailModel({
  //   this.paths = const [],
  //   this.isMoving = false,
  //   this.points = 0,
  //   Path? current,
  // }) {
  //   this.current = current ?? Path();
  // }
  //
  // ScheduleDetailModel copyWith({
  //   List<Path>? paths,
  //   bool? isMoving,
  //   int? points,
  //   Path? current,
  // }) {
  //   return ScheduleDetailModel(
  //     paths: paths ?? this.paths,
  //     isMoving: isMoving ?? this.isMoving,
  //     points: points ?? this.points,
  //     current: current ?? this.current,
  //   );
  // }
}
