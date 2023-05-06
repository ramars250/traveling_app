import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/crud_service.dart';
import 'package:traveling_app/provider.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late DateTimeRange selectedDateTime;
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final selectedRange = await showDialog<DateTimeRange>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('選擇日期'),
                            content: SizedBox(
                              width: 300,
                              height:
                                  MediaQuery.of(context).size.height * 2 / 3,
                              child: DateRangePickerDialog(
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 3, 12),
                              ),
                            ),
                          );
                        });
                    if (selectedRange != null) {
                      selectedDateTime = selectedRange;
                      ref.read(selectedDateTimeProvider.notifier).state =
                          selectedDateTime;
                    }
                  },
                  child: ref.watch(selectedDateTimeProvider) != null
                      ? Text(
                          '${selectedDateTime.start.year}-${selectedDateTime.start.month}-${selectedDateTime.start.day} -- ${selectedDateTime.end.year}-${selectedDateTime.end.month}-${selectedDateTime.end.day}')
                      : const Text('選擇日期'),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: textController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      isCollapsed: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      hintText: '請輸入要前往的地點',
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      FireCrud.addTravel(selectedDateTime, textController.text);
                      ref.read(scheduleProvider.notifier).addSchedule(
                          selectedDateTime.start.toString(),
                          selectedDateTime.end.toString(),
                          textController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('確定'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
