import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/pomodoro_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';
import 'package:myvisionary/providers/dashboard_provider.dart';

import 'features/auth/pages/auth_wrapper.dart';
import 'features/auth/pages/register_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => PomodoroProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0F1A24),
          fontFamily: "SFPro",
        ),

        home: const AuthWrapper(),

        routes: {
          "/register": (context) => const RegisterPage(),
        },
      ),
    );
  }
}