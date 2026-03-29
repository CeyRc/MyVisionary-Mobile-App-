import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/pomodoro_provider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(PomodoroProvider provider) {
    _timer?.cancel();
    provider.startTimer();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!provider.isRunning) {
        timer.cancel();
      } else {
        provider.tick();
      }
    });
  }

  void _pauseTimer(PomodoroProvider provider) {
    _timer?.cancel();
    provider.pauseTimer();
  }

  void _resetTimer(PomodoroProvider provider) {
    _timer?.cancel();
    provider.resetTimer();
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(
      builder: (context, provider, _) {
        final progress = provider.remainingSeconds / (provider.workDuration * 60);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text(
                  formatTime(provider.remainingSeconds),
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: provider.isRunning
                      ? () => _pauseTimer(provider)
                      : () => _startTimer(provider),
                  child: Text(provider.isRunning ? "Pause" : "Start"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _resetTimer(provider),
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Work: ${provider.workDuration} min | Break: ${provider.breakDuration} min",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}