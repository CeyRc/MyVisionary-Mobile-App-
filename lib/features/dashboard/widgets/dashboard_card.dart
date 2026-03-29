import 'package:flutter/material.dart';
import 'package:myvisionary/features/dashboard/pages/dashboard_detail_page.dart';

class DashboardCard extends StatelessWidget {

  final String dashboardId;
  final String dashboardName;
  final String imageUrl;
  final int completedTasks;
  final int totalTasks;
  final int focusMinutes;

  const DashboardCard({
    super.key,
    required this.dashboardId,
    required this.dashboardName,
    required this.imageUrl,
    required this.completedTasks,
    required this.totalTasks,
    required this.focusMinutes,
  });

  @override
  Widget build(BuildContext context) {

    double progress = 0;

    if (totalTasks != 0) {
      progress = completedTasks / totalTasks;
    }

    int percent = (progress * 100).toInt();

    int hours = focusMinutes ~/ 60;
    int minutes = focusMinutes % 60;

    return GestureDetector(

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardDetailPage(
              dashboardId: dashboardId,
              dashboardName: dashboardName,
            ),
          ),
        );

      },

      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 20),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.45),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// LEFT SIDE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,

                children: [

                  /// Dashboard name
                  Text(
                    dashboardName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Tasks
                  Text(
                    "$completedTasks / $totalTasks tasks",
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Focus Time
                  Text(
                    "Focus ${hours}h ${minutes}m",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),

                ],
              ),

              /// PROGRESS RING
              SizedBox(
                width: 60,
                height: 60,

                child: Stack(
                  alignment: Alignment.center,

                  children: [

                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(
                        Colors.tealAccent,
                      ),
                    ),

                    Text(
                      "$percent%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}