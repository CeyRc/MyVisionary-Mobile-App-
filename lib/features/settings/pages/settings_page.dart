import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(

        children: [

          /// PROFILE
          ListTile(

            leading: const Icon(Icons.person),

            title: const Text("Edit Profile"),

            onTap: () {},

          ),

          /// NOTIFICATIONS
          SwitchListTile(

            secondary: const Icon(Icons.notifications),

            title: const Text("Notifications"),

            value: notifications,

            onChanged: (value) {

              setState(() {
                notifications = value;
              });

            },
          ),

          /// DARK MODE
          SwitchListTile(

            secondary: const Icon(Icons.dark_mode),

            title: const Text("Dark Mode"),

            value: darkMode,

            onChanged: (value) {

              setState(() {
                darkMode = value;
              });

            },
          ),

          /// CHANGE PASSWORD
          ListTile(

            leading: const Icon(Icons.lock),

            title: const Text("Change Password"),

            onTap: () {

              showDialog(
                context: context,
                builder: (context) {

                  return const ChangePasswordDialog();

                },
              );

            },

          ),

          const Divider(),

          /// LOGOUT
          ListTile(

            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),

            title: const Text(
              "Log Out",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

            onTap: () {

              showDialog(
                context: context,
                builder: (context) {

                  return AlertDialog(

                    title: const Text("Log Out"),

                    content: const Text(
                      "Are you sure you want to log out?",
                    ),

                    actions: [

                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      TextButton(
                        child: const Text("Log Out"),

                        onPressed: () async {

                          await FirebaseAuth.instance.signOut();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/login",
                                (route) => false,
                          );

                        },
                      ),

                    ],
                  );
                },
              );

            },

          ),

        ],
      ),
    );
  }
}

class ChangePasswordDialog extends StatefulWidget {

  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text("Change Password"),

      content: TextField(
        controller: controller,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "New password",
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
          child: const Text("Update"),

          onPressed: () async {

            if (controller.text.trim().isEmpty) return;

            await FirebaseAuth.instance.currentUser!
                .updatePassword(controller.text.trim());

            Navigator.pop(context);

          },
        )

      ],
    );
  }
}