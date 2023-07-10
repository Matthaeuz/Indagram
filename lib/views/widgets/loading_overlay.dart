import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: AppColors.appBarFgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CircularProgressIndicator(
              color: AppColors.loadingColor,
            ),
          ),
          Text(
            'Loading...',
            style: TextStyle(
              color: AppColors.appBarColor,
            ),
          ),
        ],
      ),
    );
  }
}
