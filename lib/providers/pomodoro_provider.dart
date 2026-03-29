import 'dart:async';
import 'package:flutter/material.dart';
import '../data/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PomodoroProvider extends ChangeNotifier {

  final int totalSeconds = 25 * 60;

  int remainingSeconds = 25 * 60;

  Timer? _timer;

  bool isRunning = false;

  int completedSessions = 0;

  String? selectedDashboardId;

  void selectDashboard(String id) {
    selectedDashboardId = id;
    notifyListeners();
  }

  void startTimer() async {

    if (isRunning) return;

    final prefs = await SharedPreferences.getInstance();

    prefs.setInt("pomodoro_start", DateTime.now().millisecondsSinceEpoch);

    isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (remainingSeconds > 0) {

        remainingSeconds--;

      } else {

        completedSessions++;

        timer.cancel();

        remainingSeconds = totalSeconds;

        isRunning = false;

      }

      notifyListeners();
    });

    notifyListeners();
  }

  void pauseTimer() {

    _timer?.cancel();

    isRunning = false;

    notifyListeners();
  }

  void resetTimer() {

    _timer?.cancel();

    remainingSeconds = totalSeconds;

    isRunning = false;

    notifyListeners();
  }

  String get timeFormatted {

    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }


  Future<void> restoreTimer() async {

    final prefs = await SharedPreferences.getInstance();

    final start = prefs.getInt("pomodoro_start");

    if (start == null) return;

    final now = DateTime.now().millisecondsSinceEpoch;

    int passed = ((now - start) / 1000).floor();

    remainingSeconds = totalSeconds - passed;

    if (remainingSeconds < 0) {

      remainingSeconds = totalSeconds;

      completedSessions++;

      return;

    }

    startTimer();
  }
}