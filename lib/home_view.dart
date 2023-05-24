// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveling_app/crud_service.dart';
import 'package:traveling_app/provider.dart';
import 'package:traveling_app/schedule_detail_view.dart';
import 'package:traveling_app/schedule_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<QuerySnapshot> travelData =
        FirebaseFirestore.instance.collection('travel').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的行程'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: travelData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('出了點問題');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final data = snapshot.requireData;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.size,
                itemBuilder: (context, index) {
                  final scheduleItem = data.docs[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.lightBlueAccent,
                    ),
                    child: ListTile(
                      onTap: () {
                        ref.read(documentIdProvider.notifier).state = scheduleItem.id;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScheduleDetailView1()));
                      },
                      leading: Text(
                        scheduleItem['location'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        '${scheduleItem['startTime']} -- ${scheduleItem['endTime']}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          FireCrud.delTravel(scheduleItem.id);
                          ref.read(selectedDateTimeProvider.notifier).state =
                              null;
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(selectedDateTimeProvider.notifier).state = null;
          showDialog(
              context: context, builder: (context) => const ScheduleView());
        },
        tooltip: '添加行程',
        child: const Icon(Icons.add),
      ),
    );
  }
}
