// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('travel');

class FireCrud {
  //創建
  static Future addTravel(
      DateTimeRange selectedDateTime, String location) async {
    final startTimeData = Timestamp.fromDate(selectedDateTime.start);
    final endTimeData = Timestamp.fromDate(selectedDateTime.end);
    final startTime = startTimeData.toDate().toString().substring(0, 10);
    final endTime = endTimeData.toDate().toString().substring(0, 10);
    final data = {
      'startTime': startTime,
      'location': location,
      'endTime': endTime,
    };
    try {
      await _collection.add(data);
      print('success');
    } catch (e) {
      print(e);
    }
  }

  //更新
  static Future updateTravel(
      DateTimeRange selectedDateTime, String location) async {
    final startTimeData = Timestamp.fromDate(selectedDateTime.start);
    final endTimeData = Timestamp.fromDate(selectedDateTime.end);
    final startTime = startTimeData.toDate().toString().substring(0, 10);
    final endTime = endTimeData.toDate().toString().substring(0, 10);
    final data = {
      'startTime': startTime,
      'location': location,
      'endTime': endTime,
    };
    try {
      await _collection.doc().update(data);
      print('success');
    } catch (e) {
      print(e);
    }
  }

  static Future updateSchedule(documentId, byteData) async {
    final data = {
      // 'documentId': documentId,
      'image': byteData
    };
    try {
      await _collection.doc('$documentId').update(data);
    } catch (e) {
      print(e);
    }
  }

  //刪除
  static Future delTravel(docId) async {
    await _collection.doc(docId).delete().then(
        (value) => const AlertDialog(content: Text('刪除成功')),
        onError: (e) => print(e));
    // print(_collection.doc(docId).path);
  }
}
