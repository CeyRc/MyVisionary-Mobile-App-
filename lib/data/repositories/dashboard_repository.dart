import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dashboard_model.dart';

class DashboardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference getDashboardsRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('dashboards');
  }

  Future<void> addDashboard(String userId, String title) async {
    await getDashboardsRef(userId).add({
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Dashboard>> getDashboardsStream(String userId) {
    return getDashboardsRef(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Dashboard.fromFirestore(doc)).toList());
  }

  Future<void> deleteDashboard(String userId, String dashboardId) async {
    await getDashboardsRef(userId).doc(dashboardId).delete();
  }
}