import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfUserExists(String userId) async {
  final users = FirebaseFirestore.instance.collection('users');
  final snapshot = await users.where('userId', isEqualTo: userId.toString()).get();

  return snapshot.docs.isEmpty;
}