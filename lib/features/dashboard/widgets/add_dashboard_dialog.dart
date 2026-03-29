import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDashboardDialog extends StatefulWidget {
  final String userId;
  const AddDashboardDialog({super.key, required this.userId});

  @override
  State<AddDashboardDialog> createState() => _AddDashboardDialogState();
}

class _AddDashboardDialogState extends State<AddDashboardDialog> {
  final TextEditingController _titleController = TextEditingController();
  bool isLoading = false;

  void _addDashboard() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() => isLoading = true);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('dashboards')
        .add({
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });

    setState(() => isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Dashboard"),
      content: TextField(
        controller: _titleController,
        decoration: const InputDecoration(hintText: "Dashboard name"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        isLoading
            ? const CircularProgressIndicator()
            : TextButton(
          onPressed: _addDashboard,
          child: const Text("Add"),
        ),
      ],
    );
  }
}