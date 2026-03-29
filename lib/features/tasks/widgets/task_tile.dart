import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskList extends StatelessWidget {

  final String dashboardId;

  const TaskList({
    super.key,
    required this.dashboardId,
  });

  @override
  Widget build(BuildContext context) {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(

      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("dashboards")
          .doc(dashboardId)
          .collection("tasks")
          .orderBy("createdAt", descending: true)
          .snapshots(),

      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data!.docs;

        if (tasks.isEmpty) {
          return const Center(
            child: Text("No tasks yet"),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {

            final task = tasks[index];

            return ListTile(
              title: Text(task["title"]),
            );
          },
        );
      },
    );
  }
}