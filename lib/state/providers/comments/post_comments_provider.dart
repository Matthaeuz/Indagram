import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';

final postCommentsProvider = StreamProvider.autoDispose<Iterable<Comment>>(
  (ref) {
    final post = ref.watch(currentPostProvider);
    final controller = StreamController<Iterable<Comment>>();

    // initial definition of controller
    controller.onListen = () {
      controller.sink.add([]);
    };

    // missing logic for matching post ids with user id
    final subscription = FirebaseFirestore.instance
        .collection('comments')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .where("postId", isEqualTo: post.postId)
        .snapshots()
        .listen((snapshot) {
      final documents = snapshot.docs;
      final result = documents
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Comment.fromJson(
              commentId: doc.id,
              json: doc.data(),
            ),
          );
      controller.sink.add(result);
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
