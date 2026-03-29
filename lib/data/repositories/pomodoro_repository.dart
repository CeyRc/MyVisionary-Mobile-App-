import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pomodoro_model.dart';

class PomodoroRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference getPomodorosRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('pomodoros');
  }

  Future<void> addPomodoro(String userId, Pomodoro pomodoro) async {
    await getPomodorosRef(userId).add(pomodoro.toMap());
  }

  Stream<List<Pomodoro>> getPomodorosStream(String userId) {
    return getPomodorosRef(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Pomodoro.fromFirestore(doc)).toList());
  }

  Future<void> updatePomodoro(String userId, Pomodoro pomodoro) async {
    await getPomodorosRef(userId).doc(pomodoro.id).update(pomodoro.toMap());
  }

  Future<void> deletePomodoro(String userId, String pomodoroId) async {
    await getPomodorosRef(userId).doc(pomodoroId).delete();
  }
}