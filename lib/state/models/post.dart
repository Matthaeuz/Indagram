class Post {
  Post({
    required this.postId,
    required this.media,
    required this.description,
    required this.isLikeAllowed,
    required this.isCommentAllowed,
    required this.isImage,
  });

  final int postId;
  final String media;
  final String description;
  bool isLikeAllowed;
  bool isCommentAllowed;
  bool isImage;
}
