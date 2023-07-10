import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/state/models/post.dart';
import 'package:indagram/views/screens/comment_screen.dart';
import 'package:indagram/views/widgets/app_divider.dart';
import 'package:indagram/views/widgets/video_post.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key, required this.post});

  final Post post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    comments = List.from(widget.post.comments);
  }

  void addComment(Comment comment) {
    setState(() {
      comments.add(comment);
    });
  }

  void deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyColor,
      appBar: AppBar(
        title: const Text(
          'Post Details',
          style: TextStyle(
            color: AppColors.appBarFgColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.appBarFgColor,
        ),
        backgroundColor: AppColors.appBarColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              Icons.share,
              size: 20.0,
              color: AppColors.appBarFgColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              Icons.delete,
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
                widget.post.isImage
                    ? Image.file(
                        File(widget.post.media),
                        fit: BoxFit.cover,
                      )
                    : VideoPost(video: widget.post.media),
                Row(
                  children: [
                    widget.post.isLikeAllowed
                        ? IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.heart,
                              color: AppColors.appBarFgColor,
                            ),
                          )
                        : const SizedBox(),
                    widget.post.isCommentAllowed
                        ? IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CommentScreen(
                                    comments: comments,
                                    addComment: addComment,
                                    deleteComment: deleteComment,
                                  ),
                                ),
                              );
                            },
                            icon: const FaIcon(
                              Icons.mode_comment_outlined,
                              color: AppColors.appBarFgColor,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: 'User ',
                            style: const TextStyle(
                              color: AppColors.bodyTextColor,
                              fontSize: FontSizes.subtitleFontSize,
                              fontWeight: FontWeight.w800,
                            ),
                            children: [
                              TextSpan(
                                text: widget.post.description,
                                style: const TextStyle(
                                  color: AppColors.bodyTextColor,
                                  fontSize: FontSizes.subtitleFontSize,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1 Jan 2023, 12:01 AM',
                        style: TextStyle(
                          color: AppColors.bodyTextColor,
                          fontSize: FontSizes.subtitleFontSize,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const AppDivider(padding: 8.0),
                      widget.post.isLikeAllowed
                          ? const Text(
                              '0 people liked this',
                              style: TextStyle(
                                color: AppColors.bodyTextColor,
                                fontSize: FontSizes.subtitleFontSize,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          : const SizedBox(),
                      widget.post.isCommentAllowed && comments.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              itemCount:
                                  comments.length > 3 ? 3 : comments.length,
                              itemBuilder: (context, index) {
                                return RichText(
                                  text: TextSpan(
                                    text: 'User ',
                                    style: const TextStyle(
                                      color: AppColors.bodyTextColor,
                                      fontSize: FontSizes.subtitleFontSize,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: comments[index].comment,
                                        style: const TextStyle(
                                          color: AppColors.bodyTextColor,
                                          fontSize: FontSizes.subtitleFontSize,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
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
