import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard {

  final String id;
  final String title;
  final DateTime createdAt;
  final int focusMinutes;

  Dashboard({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.focusMinutes,
  });

  factory Dashboard.fromFirestore(DocumentSnapshot doc) {

    final data = doc.data() as Map<String, dynamic>;

    return Dashboard(
      id: doc.id,
      title: data['title'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      focusMinutes: data['focusMinutes'] ?? 0,
    );
  }
}