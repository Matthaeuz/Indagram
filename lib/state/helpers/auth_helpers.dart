import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> checkIfUserExists(String userId) async {
  final users = FirebaseFirestore.instance.collection('users');
  final snapshot = await users.where('userId', isEqualTo: userId.toString()).get();

  return snapshot.docs.isEmpty;
}

Future<void> signOut() async {
  await GoogleSignIn().signOut();
  await FirebaseAuth.instance.signOut();
}