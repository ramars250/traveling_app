import 'package:flutter/material.dart';
import 'package:traveling_app/crud_service.dart';
import 'package:traveling_app/path_model.dart';

class ScheduleDetailViewModel extends ChangeNotifier {
  // 路徑列表，用於存儲繪製的路徑
  final List<PathModel> paths = [];
  //選中的顏色
  Color selectedColor = Colors.black;
  //儲存路徑的點
  List<List<Offset>> pointsList = [];
  //路徑的計數器
  int points = 0;
  // 當前正在繪製的路徑
  Path? _current;
  //儲存路徑歷史紀錄
  final List<List<PathModel>> history = [];
  // 是否處於移動模式
  bool isMoving = false;
  // 選中的路徑索引
  int? _selectedPathIndex;
  // 獲取選中的路徑索引
  int? get selectedPathIndex => _selectedPathIndex;
  // 設置選中的路徑索引
  set selectedPathIndex(int? index) {
    _selectedPathIndex = index;
    notifyListeners();
  }
  // 文檔 ID
  String? _documentId;
  // 獲取文檔 ID
  String? get documentId => _documentId;
  // 設置文檔 ID
  set documentId(String? id) {
    _documentId = id;
    notifyListeners();
  }
  //處理手指按下事件，創建新的路徑並添加到列表中或選擇指定位置的路徑
  void handlePanDown(DragDownDetails details) {
    if (!isMoving) {
      // 創建新的路徑
      _current = Path();
      // 將新的路徑添加到列表中
      paths.add(PathModel(_current!, selectedColor));
      // 移動到按下的位置
      _current!.moveTo(
        details.localPosition.dx,
        details.localPosition.dy,
      );
      // 繪製線段
      _current!.lineTo(
        details.localPosition.dx + 1,
        details.localPosition.dy + 1,
      );
      notifyListeners();
    } else {
      // 選中指定位置的路徑
      setSelectedPath(details.localPosition);
    }
  }
  //處理手指移動事件，根據模式執行相應操作
  void handlePanUpdate(DragUpdateDetails details) {
    if (isMoving && selectedPathIndex != null) {
      // 移動選中的路徑
      paths[selectedPathIndex!] = paths[selectedPathIndex!]
          .shift(Offset(details.delta.dx, details.delta.dy));
      notifyListeners();
    } else {
      points++;
      // 繪製連接當前位置的線段
      _current!.lineTo(
        details.localPosition.dx,
        details.localPosition.dy,
      );
      getPointsFromPath(_current!);
      notifyListeners();
    }
  }
  //處理手指抬起事件
  void handlePanEnd() {
    if (_current != null && documentId != null) {
      // 將當前路徑轉換為字符串表示
      String testPath = _current.toString();
      // 更新文檔中的路徑信息
      FireCrud.updateSchedule(documentId, testPath);
      _current = null;
      notifyListeners();
    }
  }
  //選擇指定位置的路徑
  void setSelectedPath(Offset position) {
    selectedPathIndex = null;
    for (int i = paths.length - 1; i >= 0; i--) {
      Path path = paths[i].path;
      // 判斷位置是否在路徑的範圍內
      if (path.getBounds().inflate(20.0).contains(position)) {
        selectedPathIndex = i;
        break;
      }
    }
    notifyListeners();
  }
  // 切換移動模式
  void toggleMovingMode() {
    isMoving = !isMoving;
    // 如果退出移動模式，取消選中的路徑
    if (!isMoving && selectedPathIndex != null) {
      selectedPathIndex = null;
    }
    notifyListeners();
  }
  //從路徑中取得點的集合
  getPointsFromPath(Path path) {
    final metrics = path.computeMetrics(forceClosed: false);
    final List<List<Offset>> points = [];
    for (final metric in metrics) {
      final length = metric.length;
      const step = 1.0;
      List<Offset> pathPoints = [];
      for (double i = 1.0; i <= length; i += step) {
        final detail = metric.getTangentForOffset(i);
        if (detail != null) {
          pathPoints.add(detail.position);
        }
      }
      points.add(pathPoints);
    }
    return points;
  }
}



