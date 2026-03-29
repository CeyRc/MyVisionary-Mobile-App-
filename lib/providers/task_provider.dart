import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TaskProvider extends ChangeNotifier {

  Future<void> addTask({
    required String dashboardId,
    required String title,
  }) async {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("dashboards")
        .doc(dashboardId)
        .collection("tasks")
        .add({
      "title": title,
      "completed": false,
      "createdAt": FieldValue.serverTimestamp(),
    });

    notifyListeners();
  }
}