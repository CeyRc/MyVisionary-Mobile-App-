import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyTaskPage extends StatefulWidget {

  const DailyTaskPage({super.key});

  @override
  State<DailyTaskPage> createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {

  List<String> tasks = [];

  final TextEditingController controller = TextEditingController();

  void addTask() {

    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add(controller.text.trim());
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();

    String day = DateFormat("d").format(now);
    String month = DateFormat("MMMM").format(now);
    String weekday = DateFormat("EEEE").format(now);

    return Scaffold(

      backgroundColor: const Color(0xFF0F1A24),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {

          showDialog(
            context: context,

            builder: (_) => AlertDialog(

              title: const Text("New Task"),

              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Task name",
                ),
              ),

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                TextButton(
                  onPressed: () {

                    addTask();
                    Navigator.pop(context);

                  },
                  child: const Text("Add"),
                )

              ],
            ),
          );

        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// TARİH
              Text(
                day,
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "$month\n$weekday",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 30),

              /// TASK LİST
              Expanded(
                child: ListView.builder(

                  itemCount: tasks.length,

                  itemBuilder: (context, index) {

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Row(
                        children: [

                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                          ),

                          const SizedBox(width: 15),

                          Text(
                            tasks[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )

                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}