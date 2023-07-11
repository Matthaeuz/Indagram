import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';
import 'package:indagram/state/providers/users/auth_provider.dart';

final userLikeProvider = StreamProvider.autoDispose<bool>(
  (ref) {
    final authDetails = ref.watch(authDetailsProvider);
    final post = ref.watch(currentPostProvider);
    final controller = StreamController<bool>();

    // initial definition of controller
    controller.onListen = () {
      controller.sink.add(false);
    };

    // missing logic for matching post ids with user id
    final subscription = FirebaseFirestore.instance
        .collection('likes')
        .where("userId", isEqualTo: authDetails.userId)
        .where("postId", isEqualTo: post.postId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        controller.add(true);
      } else {
        controller.add(false);
      }
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
