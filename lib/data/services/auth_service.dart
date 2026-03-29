import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // current user
  User? get currentUser => _auth.currentUser;

  // register
  Future<User?> register(String email, String password) async {

    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  }

  // login
  Future<User?> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  }

  // logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // auth state
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

}