import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.postId,
    required this.media,
    required this.description,
    required this.isLikeAllowed,
    required this.isCommentAllowed,
    required this.isImage,
    required this.createdAt,
    required this.userId,
  });

  final String postId;
  final String media;
  final String description;
  bool isLikeAllowed;
  bool isCommentAllowed;
  bool isImage;
  final Timestamp createdAt;
  final String userId;

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
        isImage = json['isImage'] as bool,
        createdAt = json['createdAt'] as Timestamp,
        userId = json['userId'] as String;

  Map<String, dynamic> toJson() {
    return {
      'media': media,
      'description': description,
      'isLikeAllowed': isLikeAllowed,
      'isCommentAllowed': isCommentAllowed,
      'isImage': isImage,
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'userId': userId,
    };
  }
}
