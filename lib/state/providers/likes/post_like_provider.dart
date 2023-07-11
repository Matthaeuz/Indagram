import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';

final postLikeProvider = StreamProvider.autoDispose<int>(
  (ref) {
    final post = ref.watch(currentPostProvider);
    final controller = StreamController<int>.broadcast();

    // initial definition of controller
    controller.onListen = () {
      controller.sink.add(0);
    };

    // missing logic for matching post ids with user id
    final subscription = FirebaseFirestore.instance
        .collection('likes')
        .where("postId", isEqualTo: post.postId)
        .snapshots()
        .listen((snapshot) {
      controller.sink.add(snapshot.docs.length);
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
