import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/services/firestore_service.dart';
import '../../home//main_navigation.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {

  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// USER VARSA
        if (snapshot.hasData) {

          final user = snapshot.data!;

          return FutureBuilder<String>(
            future: FirestoreService().getUsername(user.uid),

            builder: (context, usernameSnapshot) {

              if (!usernameSnapshot.hasData) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              /// SWIPE NAVIGATION
              return MainNavigation(
                username: usernameSnapshot.data!,
              );
            },
          );
        }

        /// USER YOKSA
        return const LoginPage();
      },
    );
  }
}