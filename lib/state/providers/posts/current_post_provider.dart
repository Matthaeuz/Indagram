import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/state/models/post.dart';

class CurrentPostNotifier extends StateNotifier<Post> {
  CurrentPostNotifier(Post post) : super(post);

  void updateCurrentPost(Post newPost) {
    state = Post(
      postId: newPost.postId,
      media: newPost.media,
      description: newPost.description,
      isLikeAllowed: newPost.isLikeAllowed,
      isCommentAllowed: newPost.isCommentAllowed,
      isImage: newPost.isImage,
      createdAt: newPost.createdAt,
      userId: newPost.userId,
    );
  }
}

final currentPostProvider =
    StateNotifierProvider<CurrentPostNotifier, Post>((ref) {
  return CurrentPostNotifier(Post.base());
});