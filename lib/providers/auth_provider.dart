import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/services/auth_service.dart';
import '../data/services/firestore_service.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();

  User? user;

  bool isLoading = false;

  // LOGIN
  Future<String?> login(String email, String password) async {

    if (email.isEmpty || password.isEmpty) {
      return "Lütfen tüm alanları doldurun.";
    }

    try {

      isLoading = true;
      notifyListeners();

      user = await _authService.login(email, password);

      return null;

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        return "Bu email ile kayıtlı kullanıcı bulunamadı.";
      }

      if (e.code == 'wrong-password') {
        return "Şifre yanlış.";
      }

      if (e.code == 'invalid-email') {
        return "Geçersiz email formatı.";
      }

      if (e.code == 'too-many-requests') {
        return "Çok fazla hatalı giriş denemesi. Lütfen daha sonra tekrar deneyin.";
      }

      return "Giriş yapılamadı.";

    } finally {

      isLoading = false;
      notifyListeners();

    }
  }


  // REGISTER
  Future<String?> register(
      String email,
      String password,
      String username,
      int age,
      ) async {

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return "Lütfen tüm alanları doldurun.";
    }

    try {

      isLoading = true;
      notifyListeners();

      final userCredential = await _authService.register(email, password);

      if (userCredential != null) {

        await FirestoreService().createUser(
          uid: userCredential.uid,
          email: email,
          username: username,
          age: age,
        );

        user = userCredential;
      }

      return null;

    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        return "Bu email zaten kullanılıyor.";
      }

      if (e.code == 'weak-password') {
        return "Şifre çok zayıf.";
      }

      if (e.code == 'invalid-email') {
        return "Geçersiz email formatı.";
      }

      return "Kayıt oluşturulamadı.";

    } finally {

      isLoading = false;
      notifyListeners();

    }
  }

  // LOGOUT
  Future<void> logout() async {

    await _authService.logout();

    user = null;

    notifyListeners();
  }

}