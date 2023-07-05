import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Container(
        color: AppColors.bodyColor,
        padding: const EdgeInsets.all(8.0),
        child: const Text(
          'There are no posts to display.',
          style: TextStyle(
            color: AppColors.bodyTextColor,
            fontSize: FontSizes.bodyFontSize,
          ),
        ),
      );
    }
    return Container(
      color: AppColors.bodyColor,
      child: GridView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () {},
              child: GridTile(
                child: Image.file(
                  File(posts[index].media),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
