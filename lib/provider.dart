import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/schedule_notifier.dart';
import 'package:traveling_app/stroke.dart';

final selectedDateTimeProvider = StateProvider<DateTimeRange?>((ref) => null);

final locationProvider = StateProvider<String>((ref) => '');

final scheduleProvider =
    StateNotifierProvider<ScheduleNotifier, List>((ref) => ScheduleNotifier());


