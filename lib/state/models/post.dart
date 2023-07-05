class Post {
  Post(
    this.postId,
    this.media,
    this.description,
    this.isLikeAllowed,
    this.isCommentAllowed,
  );

  final int postId;
  final String media;
  final String description;
  bool isLikeAllowed;
  bool isCommentAllowed;
}
