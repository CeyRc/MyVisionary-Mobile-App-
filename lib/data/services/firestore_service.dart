import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// USERNAME GET
  Future<String> getUsername(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();

    if (doc.exists) {
      return doc.data()?["username"] ?? "User";
    }

    return "User";
  }

  /// CREATE USER
  Future<void> createUser({
    required String uid,
    required String email,
    required String username,
    required int age,
  }) async {
    await _db.collection("users").doc(uid).set({
      "email": email,
      "username": username,
      "age": age,
      "premium": false,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// CREATE DASHBOARD (DÜZELTİLDİ)
  Future<void> createDashboard({
    required String title,
  }) async {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("dashboards")
        .add({
      "title": title,
      "progress": 0,
      "focusMinutes": 0,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// GET USER DASHBOARDS (DÜZELTİLDİ)
  Stream<QuerySnapshot> getUserDashboards() {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection("users")
        .doc(uid)
        .collection("dashboards")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  /// ADD TASK
  Future<void> addTask({
    required String dashboardId,
    required String title,
  }) async {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db
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
  }



  Future<void> addFocusTime({
    required String dashboardId,
    required int minutes,
  }) async {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("dashboards")
        .doc(dashboardId)
        .update({
      "focusMinutes": FieldValue.increment(minutes),
    });
  }

}