import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/providers/users/auth_provider.dart';

import 'package:indagram/views/screens/home_screen.dart';
import 'package:indagram/views/widgets/app_divider.dart';
import 'package:indagram/views/widgets/github_button.dart';
import 'package:indagram/views/widgets/google_button.dart';

import 'package:indagram/helpers/auth/google_login.dart';
import 'package:indagram/helpers/auth/github_login.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppTexts.appBarText,
          style: TextStyle(
            color: AppColors.appBarFgColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: AppColors.bodyColor,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Spacer(),
                  const SizedBox(height: 20.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTexts.titleText,
                      style: TextStyle(
                        color: AppColors.bodyTextColor,
                        fontSize: FontSizes.titleFontSize,
                      ),
                    ),
                  ),
                  const AppDivider(padding: 40.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTexts.loginText,
                      style: TextStyle(
                        color: AppColors.bodyTextColor,
                        fontSize: FontSizes.bodyFontSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      final user = await google_signin(context);

                      debugPrint('google login: $user');

                      if (user != null) {
                        // save google auth credentials to provider
                        var displayName = user
                                .additionalUserInfo?.profile?['given_name'] +
                            ' ' +
                            user.additionalUserInfo?.profile?['family_name'];

                        ref.read(authDetailsProvider.notifier).updateUser(
                              displayName,
                              user.additionalUserInfo?.profile?['id'],
                              user.additionalUserInfo?.profile?['email'],
                            );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else {
                        // was not able to sign in; throw an error
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.loginButtonColor,
                      foregroundColor: AppColors.loginButtonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const GoogleButton(),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      final user = await signInWithGitHub();
                      debugPrint('$user');
                      if (user != null) {
                        // save userdetails in authprovider
                        ref.read(authDetailsProvider.notifier).updateUser(
                              user.additionalUserInfo?.profile?['login'],
                              user.additionalUserInfo?.profile?['id'],
                              user.additionalUserInfo?.profile?['email'],
                            );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.loginButtonColor,
                      foregroundColor: AppColors.loginButtonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const GithubButton(),
                  ),
                  const AppDivider(padding: 40.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Don\'t have an account?\nSign up on Google or create an account on Github',
                      style: TextStyle(
                        color: AppColors.bodyTextColor,
                        fontSize: FontSizes.bodyFontSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
