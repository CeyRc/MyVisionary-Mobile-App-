import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/services/firestore_service.dart';
import '../widgets/dashboard_card.dart';
import '../../profile/pages/profile_page.dart';
import '../../settings/pages/settings_page.dart';

class DashboardPage extends StatelessWidget {
  final String username;

  const DashboardPage({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {

    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1A24),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          createDashboard(context);
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Your life, at a glance ✨",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Welcome $username",
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [

                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfilePage(),
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),

              /// DASHBOARD LIST
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreService().getUserDashboards(),

                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final dashboards = snapshot.data?.docs ?? [];

                    if (dashboards.isEmpty) {
                      return const Center(
                        child: Text(
                          "Built it your way",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: dashboards.length,

                      itemBuilder: (context, index) {

                        final data = dashboards[index];

                        /// SAFE MAP
                        final dashboardData =
                        data.data() as Map<String, dynamic>;

                        final focusMinutes =
                            dashboardData["focusMinutes"] ?? 0;

                        return StreamBuilder<QuerySnapshot>(

                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId)
                              .collection("dashboards")
                              .doc(data.id)
                              .collection("tasks")
                              .snapshots(),

                          builder: (context, taskSnapshot) {

                            if (!taskSnapshot.hasData) {

                              return DashboardCard(
                                dashboardId: data.id,
                                dashboardName: dashboardData["title"],
                                imageUrl: "https://picsum.photos/400",
                                completedTasks: 0,
                                totalTasks: 0,
                                focusMinutes: focusMinutes,
                              );
                            }

                            final tasks = taskSnapshot.data!.docs;

                            int completed = tasks
                                .where((task) => task["completed"] == true)
                                .length;

                            int total = tasks.length;

                            return DashboardCard(
                              dashboardId: data.id,
                              dashboardName: dashboardData["title"],
                              imageUrl: "https://picsum.photos/400",
                              completedTasks: completed,
                              totalTasks: total,
                              focusMinutes: focusMinutes,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createDashboard(BuildContext context) {

    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Create Dashboard"),

          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Dashboard name",
            ),
          ),

          actions: [

            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            TextButton(
              child: const Text("Create"),

              onPressed: () async {

                if (controller.text.trim().isEmpty) return;

                await FirestoreService().createDashboard(
                  title: controller.text.trim(),
                );

                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}