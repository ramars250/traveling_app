import 'package:flutter/material.dart';
import 'package:traveling_app/crud_service.dart';

class ScheduleDetailViewModel extends ChangeNotifier {
  final List<Path> paths = [];
  int points = 0;
  Path? _current;

  bool isMoving = false;

  int? _selectedPathIndex;

  int? get selectedPathIndex => _selectedPathIndex;

  set selectedPathIndex(int? index) {
    _selectedPathIndex = index;
    notifyListeners();
  }

  String? _documentId;

  String? get documentId => _documentId;

  set documentId(String? id) {
    _documentId = id;
    notifyListeners();
  }

  void handlePanDown(DragDownDetails details) {
    if (!isMoving) {
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
      notifyListeners();
    } else {
      setSelectedPath(details.localPosition);
    }
  }

  void handlePanUpdate(DragUpdateDetails details) {
    if (isMoving && selectedPathIndex != null) {
      paths[selectedPathIndex!] = paths[selectedPathIndex!]
          .shift(Offset(details.delta.dx, details.delta.dy));
      notifyListeners();
    } else {
      points++;
      _current!.lineTo(
        details.localPosition.dx,
        details.localPosition.dy,
      );
      notifyListeners();
    }
  }

  void handlePanEnd() {
    if (_current != null && documentId != null) {
      String testPath = _current.toString();
      FireCrud.updateSchedule(documentId, testPath);
      _current = null;
      notifyListeners();
    }
  }

  void setSelectedPath(Offset position) {
    selectedPathIndex = null;
    for (int i = paths.length - 1; i >= 0; i--) {
      Path path = paths[i];
      if (path.getBounds().inflate(20.0).contains(position)) {
        selectedPathIndex = i;
        break;
      }
    }
    notifyListeners();
  }

  void toggleMovingMode() {
    isMoving = !isMoving;
    if (!isMoving && selectedPathIndex != null) {
      selectedPathIndex = null;
    }
    notifyListeners();
  }
}



