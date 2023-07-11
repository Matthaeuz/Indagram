class Like {
  Like({
    required this.likeId,
    required this.userId,
    required this.postId,
  });

  final String likeId;
  final String userId;
  final String postId;

  // constructor that unpacks doc.data()
  Like.fromJson({
    required this.likeId,
    required Map<String, dynamic> json,
  })  : userId = json['userId'] as String,
        postId = json['postId'] as String;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
    };
  }
}
