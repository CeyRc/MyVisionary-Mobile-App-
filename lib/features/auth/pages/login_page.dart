import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {

                final error = await authProvider.login(
                  emailController.text,
                  passwordController.text,
                );

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

              },
              child: authProvider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              child: const Text("Create Account"),
            )

          ],
        ),
      ),
    );
  }
}