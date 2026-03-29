import 'package:cloud_firestore/cloud_firestore.dart';

class Pomodoro {
  final String id;
  final int workDuration; // dakika cinsinden
  final int breakDuration; // dakika cinsinden
  final int completedSessions; // tamamlanan Pomodoro seans sayısı
  final Timestamp createdAt;

  Pomodoro({
    required this.id,
    required this.workDuration,
    required this.breakDuration,
    required this.completedSessions,
    required this.createdAt,
  });

  factory Pomodoro.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pomodoro(
      id: doc.id,
      workDuration: data['workDuration'] ?? 25,
      breakDuration: data['breakDuration'] ?? 5,
      completedSessions: data['completedSessions'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'completedSessions': completedSessions,
      'createdAt': createdAt,
    };
  }
}