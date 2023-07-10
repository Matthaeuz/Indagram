import 'package:indagram/state/models/comment.dart';

class Post {
  Post({
    required this.postId,
    required this.media,
    required this.description,
    required this.isLikeAllowed,
    required this.isCommentAllowed,
    required this.isImage,
  });

  final String postId;
  final String media;
  final String description;
  final List<Comment> comments = [];
  bool isLikeAllowed;
  bool isCommentAllowed;
  bool isImage;

  // constructor that unpacks doc.data()
  Post.fromJson({
    required this.postId,
    required Map<String, dynamic> json,
  })  : media = json['media'] as String,
        description = json['description'] as String,
        isLikeAllowed =
            json['isLikeAllowed'] as bool? ?? false, // added null safety
        isCommentAllowed =
            json['isCommentAllowed'] as bool? ?? false, // added null safety
        isImage = json['isImage'] as bool;

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'media': media,
      'description': description,
      'isLikeAllowed': isLikeAllowed,
      'isCommentAllowed': isCommentAllowed,
      'isImage': isImage,
    };
  }
}
