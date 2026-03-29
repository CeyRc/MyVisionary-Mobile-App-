import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {

                // boş alan kontrolü
                if (usernameController.text.isEmpty ||
                    ageController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lütfen tüm alanları doldurun"),
                    ),
                  );
                  return;
                }

                // yaş kontrolü
                final age = int.tryParse(ageController.text);

                if (age == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Age must be a number"),
                    ),
                  );
                  return;
                }

                final error = await authProvider.register(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  usernameController.text.trim(),
                  age,
                );

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account created successfully"),
                    ),
                  );

                  Navigator.pop(context);
                }

              },

              child: authProvider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Create Account"),
            )

          ],
        ),
      ),
    );
  }
}