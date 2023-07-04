import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/views/screens/home_screen.dart';
import 'package:indagram/views/widgets/app_divider.dart';
import 'package:indagram/views/widgets/github_button.dart';
import 'package:indagram/views/widgets/google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
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
                    onPressed: () {},
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
