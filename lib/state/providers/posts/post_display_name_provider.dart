import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final displayNameProvider = StreamProvider.autoDispose.family<AsyncValue<String>, String>((ref, userId) {
  final userCollection = FirebaseFirestore.instance.collection('users');

  return userCollection
      .where('userId', isEqualTo: userId)
      .limit(1)
      .snapshots()
      .map<AsyncValue<String>>((snapshot) => 
        snapshot.docs.isNotEmpty
          ? AsyncValue.data(snapshot.docs.first.get('displayName') as String)
          : const AsyncValue<String>.data('')
      );
});
