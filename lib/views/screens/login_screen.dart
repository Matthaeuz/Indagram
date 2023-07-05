import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';

import 'package:indagram/views/screens/home_screen.dart';
import 'package:indagram/views/widgets/app_divider.dart';
import 'package:indagram/views/widgets/github_button.dart';
import 'package:indagram/views/widgets/google_button.dart';

import 'package:indagram/helpers/auth/google_login.dart';
import 'package:indagram/helpers/auth/github_login.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      google_signin(context);
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

                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
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
