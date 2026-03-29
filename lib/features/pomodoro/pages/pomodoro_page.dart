import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/pomodoro_provider.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../data/models/dashboard_model.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();

  @override
  Widget build(BuildContext context) {

    final pomodoro = Provider.of<PomodoroProvider>(context);

    return Scaffold(

      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        title: const Text("Pomodoro"),
        backgroundColor: const Color(0xFF0F172A),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            /// DASHBOARD SELECT
            StreamBuilder<List<Dashboard>>(

              stream: context.read<DashboardProvider>().dashboardsStream,

              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final dashboards = snapshot.data!;

                return Column(

                  children: [

                    const Text(
                      "Focus on",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    DropdownButton<String>(

                      dropdownColor: const Color(0xFF1E293B),

                      value: pomodoro.selectedDashboardId,

                      hint: const Text(
                        "Select Dashboard",
                        style: TextStyle(color: Colors.white),
                      ),

                      items: dashboards.map((dashboard) {

                        return DropdownMenuItem(
                          value: dashboard.id,
                          child: Text(
                            dashboard.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );

                      }).toList(),

                      onChanged: (value) {

                        context
                            .read<PomodoroProvider>()
                            .selectDashboard(value!);

                      },
                    ),

                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            /// TIMER
            Text(
              pomodoro.timeFormatted,
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),

                  onPressed: pomodoro.startTimer,

                  child: const Text("Start"),
                ),

                const SizedBox(width: 20),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),

                  onPressed: pomodoro.pauseTimer,

                  child: const Text("Pause"),
                ),

                const SizedBox(width: 20),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),

                  onPressed: pomodoro.resetTimer,

                  child: const Text("Reset"),
                ),

              ],
            ),

            const SizedBox(height: 50),

            /// STATS
            const Text(
              "Completed Today",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "${pomodoro.completedSessions}",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

          ],
        ),
      ),
    );
  }
}