import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.action,
    required this.onSubmit,
  });

  final String title;
  final String subtitle;
  final String action;
  final Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.appBarColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.appBarFgColor,
          fontSize: FontSizes.bodyFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.appBarFgColor,
          fontSize: FontSizes.subtitleFontSize,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.tabIndicatorColor,
            ),
          ),
        ),
        TextButton(
          onPressed: onSubmit,
          child: Text(
            action,
            style: const TextStyle(
              color: AppColors.tabIndicatorColor,
            ),
          ),
        ),
      ],
    );
  }
}
