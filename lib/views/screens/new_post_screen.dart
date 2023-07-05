import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key, required this.media, required this.addPost});

  final String media;
  final void Function(Post) addPost;

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Post',
          style: TextStyle(
            color: AppColors.appBarFgColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              widget.addPost(Post(1, widget.media, '', true, true));
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              Icons.send,
              color: AppColors.appBarFgColor,
            ),
          ),
        ],
      ),
      body: Image.file(
        File(widget.media),
        fit: BoxFit.cover,
      ),
    );
  }
}
