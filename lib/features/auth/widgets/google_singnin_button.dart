import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../pages/dashboard_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => isLoading = true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => isLoading = false);
        return; // kullanıcı iptal etti
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) return;

      // Firestore’da user kaydı yoksa oluştur
      final docRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid);
      final doc = await docRef.get();
      if (!doc.exists) {
        await docRef.set({
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // name alanı yoksa onboarding, varsa dashboard
      final doc2 = await docRef.get();
      if (!doc2.exists || !(doc2.data()!.containsKey('name'))) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : _signInWithGoogle,
      icon: Image.asset(
        "assets/images/google_logo.png",
        height: 24,
        width: 24,
      ),
      label: isLoading
          ? const SizedBox(
          width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
          : const Text("Sign in with Google"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}