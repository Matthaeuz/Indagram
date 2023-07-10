import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/state/models/user.dart';

class AuthDetailsNotifier extends StateNotifier<User> {
  AuthDetailsNotifier(User user) : super(user);

  void updateUser(String newDisplayName, String newUserId, String newEmail) {
    state = User(
      displayName: newDisplayName,
      userId: newUserId,
      email: newEmail,
    );
  }
}

final authDetailsProvider = StateNotifierProvider<AuthDetailsNotifier, User>((ref) {
  return AuthDetailsNotifier(User(
    displayName: '',
    userId: '',
    email: '',
  ));
});