import 'dart:ui';

class ScheduleDetailModel {
  // 路徑列表
  final List<Path> paths;
  final int points;
  // 當前路徑
  final Path? current;
  // 是否處於移動模式
  final bool isMoving;
  // 選中的路徑索引
  final int? selectedPathIndex;
  // 文檔 ID
  final String? documentId;

  List<List<Offset>> pointsList = [];

  ScheduleDetailModel({
    required this.paths,
    required this.points,
    required this.current,
    required this.isMoving,
    required this.selectedPathIndex,
    required this.documentId,
    required this.pointsList,
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
      // 更新路徑列表
      paths: paths ?? this.paths,
      points: points ?? this.points,
      // 更新當前路徑
      current: current ?? this.current,
      // 更新移動模式
      isMoving: isMoving ?? this.isMoving,
      // 更新選中的路徑索引
      selectedPathIndex: selectedPathIndex ?? this.selectedPathIndex,
      // 更新文檔 ID
      documentId: documentId ?? this.documentId,
      pointsList: pointsList,
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
