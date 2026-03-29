import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskItem extends StatelessWidget {

  final String title;
  final bool completed;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.title,
    required this.completed,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,

      onDismissed: (_) {
        onDelete();
      },

      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: const Color(0xFF6F9C9C),
          borderRadius: BorderRadius.circular(30),
        ),

        child: Row(
          children: [

            GestureDetector(
              onTap: onToggle,

              child: Container(
                width: 26,
                height: 26,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}