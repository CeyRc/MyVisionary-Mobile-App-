import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myvisionary/features/tasks/widgets/task_list.dart';
import 'package:myvisionary/features/tasks/widgets/add_task_dialog.dart';

class DashboardDetailPage extends StatefulWidget {

  final String dashboardId;
  final String dashboardName;

  const DashboardDetailPage({
    super.key,
    required this.dashboardId,
    required this.dashboardName,
  });

  @override
  State<DashboardDetailPage> createState() => _DashboardDetailPageState();
}

class _DashboardDetailPageState extends State<DashboardDetailPage> {

  @override
  Widget build(BuildContext context) {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.dashboardName),
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("dashboards")
            .doc(widget.dashboardId)
            .collection("tasks")
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;

          int completed =
              tasks.where((t) => t["completed"] == true).length;

          int total = tasks.length;

          double progress = total == 0 ? 0 : completed / total;

          return Column(
            children: [

              const SizedBox(height: 30),

              /// PROGRESS CIRCLE
              Stack(
                alignment: Alignment.center,
                children: [

                  SizedBox(
                    width: 130,
                    height: 130,

                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 10,
                    ),
                  ),

                  Text(
                    "${(progress * 100).toInt()}%",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// TASK LIST
              Expanded(
                child: TaskList(
                  dashboardId: widget.dashboardId,
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          showDialog(
            context: context,
            builder: (_) => AddTaskDialog(
              dashboardId: widget.dashboardId,
            ),
          );

        },
      ),
    );
  }
}