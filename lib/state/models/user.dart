class User {
  User({
    required this.displayName,
    required this.userId,
    required this.email,
  });

  final String displayName;
  final String userId;
  final String? email;

  // constructor that unpacks doc.data()
  User.fromJson({
    required Map<String, dynamic> json,
  })  : displayName = json['displayName'] as String,
        userId = json['userId'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'userId': userId,
      'email': email,
    };
  }
}
