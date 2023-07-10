import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/state/models/user.dart';

class AuthDetailsNotifier extends StateNotifier<User> {
  AuthDetailsNotifier(User user) : super(user);

  void updateUser(User newUser) {
    state = User(
      displayName: newUser.displayName,
      userId: newUser.userId,
      email: newUser.email,
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