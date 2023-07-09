import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/models/post.dart';

final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final controller = StreamController<Iterable<Post>>();

    // initial definition of controller
    controller.onListen = () {
      controller.sink.add([]);
    };

    final subscription = FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .listen((snapshot) {
      final documents = snapshot.docs;
      final result = documents
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Post.fromJson(
              postId: doc.id,
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
