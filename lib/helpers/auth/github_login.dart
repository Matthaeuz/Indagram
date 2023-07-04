import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signInWithGitHub() async {
  GithubAuthProvider githubProvider = GithubAuthProvider();

  try {
    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  } catch (e, stackTrace) {
    print('An error occurred while signing in with GitHub: $e');
    print('Stack trace: $stackTrace');
    throw (e);
  }
}
