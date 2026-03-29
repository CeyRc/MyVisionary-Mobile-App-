import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/task_provider.dart';

class AddTaskDialog extends StatefulWidget {

  final String dashboardId;

  const AddTaskDialog({
    super.key,
    required this.dashboardId,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text("Create Task"),

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

        ElevatedButton(
          onPressed: () async {

            if (controller.text.isEmpty) return;

            await context.read<TaskProvider>().addTask(
              dashboardId: widget.dashboardId,
              title: controller.text,
            );

            Navigator.pop(context);
          },
          child: const Text("Create"),
        )

      ],
    );
  }
}