import 'dart:ui';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// PROFILE CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2A36),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Stay focused on your goals",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// STATS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: const [

                StatCard(
                  icon: Icons.local_fire_department,
                  title: "34",
                  subtitle: "Day Streak",
                ),

                StatCard(
                  icon: Icons.star,
                  title: "15",
                  subtitle: "Goals",
                ),

                StatCard(
                  icon: Icons.emoji_events,
                  title: "285",
                  subtitle: "XP",
                ),

              ],
            ),

            const SizedBox(height: 30),

            /// WEEKLY REVIEW (PREMIUM)
            Stack(
              children: [

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2A36),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text(
                        "Weekly Review",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Tasks Completed: 42",
                        style: TextStyle(color: Colors.white70),
                      ),

                      Text(
                        "Focus Time: 6h",
                        style: TextStyle(color: Colors.white70),
                      ),

                      Text(
                        "Best Day: Tuesday",
                        style: TextStyle(color: Colors.white70),
                      ),

                    ],
                  ),
                ),

                /// BLUR EFFECT
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 6,
                        sigmaY: 6,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),

                /// LOCK ICON
                const Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 40,
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Premium Feature",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),

            /// SETTINGS
            const SettingsItem(
              icon: Icons.person,
              title: "Edit Profile",
            ),

            const SettingsItem(
              icon: Icons.notifications,
              title: "Notifications",
            ),

            const SettingsItem(
              icon: Icons.dark_mode,
              title: "App Theme",
            ),

          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF1C2A36),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.tealAccent,
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {

  final IconData icon;
  final String title;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: const Color(0xFF1C2A36),
        borderRadius: BorderRadius.circular(15),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.tealAccent,
        ),

        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
      ),
    );
  }
}