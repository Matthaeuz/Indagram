import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final displayNameProvider = StreamProvider.autoDispose.family<String, String>((ref, userId) {
  final userCollection = FirebaseFirestore.instance.collection('users');

  return userCollection
      .where('userId', isEqualTo: userId)
      .limit(1)
      .snapshots()
      .map((snapshot) => snapshot.docs.isNotEmpty ? snapshot.docs.first.get('displayName') : '');
});