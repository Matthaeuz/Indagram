import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bodyColor,
      child: const Text(
        'Search Tab',
        style: TextStyle(
          color: AppColors.bodyTextColor,
          fontSize: FontSizes.bodyFontSize,
        ),
      ),
    );
  }
}
