import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';
import 'package:indagram/state/providers/posts/user_posts_provider.dart';
import 'package:indagram/state/providers/users/auth_provider.dart';
import 'package:indagram/views/widgets/video_thumb.dart';

class NewPostScreen extends ConsumerStatefulWidget {
  const NewPostScreen({
    super.key,
    required this.media,
    required this.isImage,
  });

  final String media;
  final bool isImage;

  @override
  ConsumerState<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends ConsumerState<NewPostScreen> {
  TextEditingController descriptionController = TextEditingController();
  bool isLikeAllowed = true;
  bool isCommentAllowed = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authDetails = ref.watch(authDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Post',
          style: TextStyle(
            color: AppColors.appBarFgColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.appBarFgColor,
        ),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Post newPost = Post(
                postId: "",
                media: widget.media,
                description: descriptionController.text,
                isLikeAllowed: isLikeAllowed,
                isCommentAllowed: isCommentAllowed,
                isImage: widget.isImage,
                createdAt: Timestamp.fromDate(DateTime.now()),
                userId: authDetails.userId,
              );
              // add new post infirestore
              try {
                await FirebaseFirestore.instance
                    .collection('posts')
                    .doc()
                    .set(newPost.toJson());
                // ignore: unused_result
                ref.refresh(userPostsProvider);
              } catch (e) {
                debugPrint(e.toString());
              } finally {
                Navigator.of(context).pop();
              }       
            },
            icon: const FaIcon(
              Icons.send,
              size: 20.0,
              color: AppColors.appBarFgColor,
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.bodyColor,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                widget.isImage
                    ? Image.file(
                        File(widget.media),
                        fit: BoxFit.cover,
                      )
                    : VideoThumb(video: widget.media),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descriptionController,
                    style: const TextStyle(
                      color: AppColors.appBarFgColor,
                      fontSize: FontSizes.bodyFontSize,
                    ),
                    decoration: const InputDecoration(
                      labelText: AppTexts.descFieldText,
                      labelStyle: TextStyle(
                        color: AppColors.activeFieldColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeFieldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Allow likes\n',
                            style: TextStyle(
                              color: AppColors.appBarFgColor,
                              fontSize: FontSizes.bodyFontSize,
                            ),
                            children: [
                              TextSpan(
                                text: AppTexts.allowLikeText,
                                style: TextStyle(
                                  color: AppColors.bodyTextColor,
                                  fontSize: FontSizes.subtitleFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 32.0),
                      Switch(
                        value: isLikeAllowed,
                        onChanged: (value) {
                          setState(() {
                            isLikeAllowed = value;
                          });
                        },
                        activeColor: AppColors.activeSwitchColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Allow comments\n',
                            style: TextStyle(
                              color: AppColors.appBarFgColor,
                              fontSize: FontSizes.bodyFontSize,
                            ),
                            children: [
                              TextSpan(
                                text: AppTexts.allowCommentText,
                                style: TextStyle(
                                  color: AppColors.bodyTextColor,
                                  fontSize: FontSizes.subtitleFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 32.0),
                      Switch(
                        value: isCommentAllowed,
                        onChanged: (value) {
                          setState(() {
                            isCommentAllowed = value;
                          });
                        },
                        activeColor: AppColors.activeSwitchColor,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
