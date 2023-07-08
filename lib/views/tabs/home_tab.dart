import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bodyColor,
      child: const Text(
        'Home Tab',
        style: TextStyle(
          color: AppColors.bodyTextColor,
          fontSize: FontSizes.bodyFontSize,
        ),
      ),
    );
  }
}
