import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/dashboard_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardProvider extends ChangeNotifier {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List<Dashboard> dashboards = [];

  Stream<List<Dashboard>> get dashboardsStream {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dashboards')
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Dashboard.fromFirestore(doc)).toList());
  }

  Future<void> addDashboard(String title) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dashboards')
        .add({
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteDashboard(String dashboardId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dashboards')
        .doc(dashboardId)
        .delete();
  }
}