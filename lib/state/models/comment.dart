import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({
    required this.commentId,
    required this.userId,
    required this.postId,
    required this.comment,
    required this.createdAt,
  });

  final String commentId;
  final String userId;
  final String postId;
  final String comment;
  final Timestamp createdAt;

  // constructor that unpacks doc.data()
  Comment.fromJson({
    required this.commentId,
    required Map<String, dynamic> json,
  })  : userId = json['userId'] as String,
        postId = json['postId'] as String,
        comment = json['comment'] as String,
        createdAt = json['createdAt'] as Timestamp;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
      'comment': comment,
      'createdAt': Timestamp.fromDate(DateTime.now()),
    };
  }
}
