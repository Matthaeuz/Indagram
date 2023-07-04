import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, required this.padding});

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: const Divider(
        color: AppColors.appBarColor,
      ),
    );
  }
}
