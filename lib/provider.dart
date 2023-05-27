import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/schedule_notifier.dart';
import 'package:traveling_app/schedule_detail_viewmodel.dart';

final selectedDateTimeProvider = StateProvider<DateTimeRange?>((ref) => null);

final locationProvider = StateProvider<String>((ref) => '');

final scheduleProvider =
    StateNotifierProvider<ScheduleNotifier, List>((ref) => ScheduleNotifier());
//選中文檔Id
final documentIdProvider = StateProvider<String>((ref) => '');
//選中的路徑
final selectedPathProvider = StateProvider<int?>((ref) => null);
//detail頁面的provider
final scheduleDetailViewModelProvider =
    ChangeNotifierProvider((ref) => ScheduleDetailViewModel());
