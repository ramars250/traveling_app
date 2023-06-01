import 'package:flutter/material.dart';
//PathModel類
class PathModel {
  //路徑對象
  Path path;
  //路徑顏色
  final Color color;
  //構造函數，初始化路徑和顏色
  PathModel(this.path, this.color);
  //將路徑按照偏移量移動並返回新的PathModel對象
  PathModel shift(Offset offset) {
    final shiftedPath = _shiftPath(path, offset);
    return PathModel(shiftedPath, color);
  }
  //將路徑根據偏移量進行移動
  Path _shiftPath(Path path, Offset offset) {
    final shiftPath = Path();
    path = path.shift(offset);
    shiftPath.addPath(path, Offset.zero);
    return shiftPath;
  }
}