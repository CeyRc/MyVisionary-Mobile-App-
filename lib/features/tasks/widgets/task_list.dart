import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'task_item.dart';


class TaskList extends StatelessWidget {

  final String dashboardId;

  const TaskList({super.key, required this.dashboardId});

  @override
  Widget build(BuildContext context) {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(

      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("dashboards")
          .doc(dashboardId)
          .collection("tasks")
          .snapshots(),

      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data!.docs;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {

            final task = tasks[index];

            return TaskItem(

              title: task["title"],
              completed: task["completed"],

              onToggle: () {
                task.reference.update({
                  "completed": !task["completed"]
                });
              },

              onDelete: () {
                task.reference.delete();
              },
            );
          },
        );
      },
    );
  }
}