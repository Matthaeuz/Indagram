import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bodyColor,
      child: const Text(
        'User Tab',
        style: TextStyle(
          color: AppColors.bodyTextColor,
          fontSize: FontSizes.bodyFontSize,
        ),
      ),
    );
  }
}
