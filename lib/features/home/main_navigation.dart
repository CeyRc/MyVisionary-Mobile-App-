import 'package:flutter/material.dart';

import '../../dashboard/pages/dashboard_page.dart';
import '../../pomodoro/pages/pomodoro_page.dart';
import '../../tasks/pages/daily_tasks_page.dart';

class MainNavigation extends StatelessWidget {

  final String username;

  const MainNavigation({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {

    final PageController controller = PageController(
      initialPage: 1,
    );

    return Scaffold(

      body: PageView(
        controller: controller,

        children: [

          /// SOL
          PomodoroPage(),

          /// ORTA
          DashboardPage(username: username),

          /// SAĞ
          DailyTaskPage(),

        ],
      ),
    );
  }
}