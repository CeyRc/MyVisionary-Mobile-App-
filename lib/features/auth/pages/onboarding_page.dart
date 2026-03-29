import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../dashboard/pages/dashboard_page.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  bool isLoading = false;

  void _submit() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());

    if (name.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid name and age")),
      );
      return;
    }

    setState(() => isLoading = true);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      'name': name,
      'age': age,
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    setState(() => isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Tell us a bit about yourself"),
            const SizedBox(height: 32),
            CustomTextField(
              controller: nameController,
              hintText: "Your Name",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: ageController,
              hintText: "Your Age",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
              text: "Continue",
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}