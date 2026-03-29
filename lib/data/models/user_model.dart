import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String id;
  final String? name;
  final int? age;
  final String? email;
  final Timestamp createdAt;

  MyUser({
    required this.id,
    this.name,
    this.age,
    this.email,
    required this.createdAt,
  });

  factory MyUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MyUser(
      id: doc.id,
      name: data['name'],
      age: data['age'],
      email: data['email'],
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'createdAt': createdAt,
    };
  }
}