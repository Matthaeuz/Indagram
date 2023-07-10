import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/state/models/post.dart';
import 'package:indagram/state/providers/posts/all_posts_provider.dart';
// import 'package:indagram/state/models/post.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';
import 'package:indagram/state/providers/posts/user_posts_provider.dart';
import 'package:indagram/state/providers/users/auth_provider.dart';
import 'package:indagram/views/screens/comment_screen.dart';
import 'package:indagram/views/widgets/app_divider.dart';
import 'package:indagram/views/widgets/video_post.dart';
import 'package:intl/intl.dart';

class PostDetailsScreen extends ConsumerStatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  ConsumerState<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends ConsumerState<PostDetailsScreen> {
  List<Comment> comments = [];
  bool isLiked = false;

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
    final authDetails = ref.watch(authDetailsProvider);
    final post = ref.watch(currentPostProvider);
    final posts = ref.watch(allPostsProvider);

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
          authDetails.userId == post.userId
              ? IconButton(
                  onPressed: () async {
                    try {
                      await FirebaseFirestore.instance
                          .collection('posts')
                          .doc(post.postId)
                          .delete();

                      //if was able to delete firestore let provider know
                      ref
                          .read(currentPostProvider.notifier)
                          .updateCurrentPost(Post.base());

                      ref.refresh(allPostsProvider);
                      ref.refresh(userPostsProvider);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  icon: const FaIcon(
                    Icons.delete,
                    size: 20.0,
                    color: AppColors.appBarFgColor,
                  ),
                )
              : const SizedBox()
        ],
      ),
      body: post.postId == ''
          ? Container(
              color: AppColors.bodyColor,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Something wrong happened. This post may be missing.',
                style: TextStyle(
                  color: AppColors.bodyTextColor,
                  fontSize: FontSizes.bodyFontSize,
                ),
              ),
            )
          : Container(
              color: AppColors.bodyColor,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      post.isImage
                          ? Image.network(
                              post.media,
                              fit: BoxFit.cover,
                            )
                          : VideoPost(video: post.media),
                      Row(
                        children: [
                          post.isLikeAllowed
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                  icon: FaIcon(
                                    isLiked
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: AppColors.appBarFgColor,
                                  ),
                                )
                              : const SizedBox(),
                          post.isCommentAllowed
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
                                  text: '${authDetails.displayName} ',
                                  style: const TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: FontSizes.subtitleFontSize,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: post.description,
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
                            Text(
                              DateFormat('d MMM y, h:mm a')
                                  .format(post.createdAt.toDate()),
                              style: const TextStyle(
                                color: AppColors.bodyTextColor,
                                fontSize: FontSizes.subtitleFontSize,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const AppDivider(padding: 8.0),
                            post.isLikeAllowed
                                ? const Text(
                                    '0 people liked this',
                                    style: TextStyle(
                                      color: AppColors.bodyTextColor,
                                      fontSize: FontSizes.subtitleFontSize,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                : const SizedBox(),
                            post.isCommentAllowed && comments.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    itemCount: comments.length > 3
                                        ? 3
                                        : comments.length,
                                    itemBuilder: (context, index) {
                                      return RichText(
                                        text: TextSpan(
                                          text: 'User ',
                                          style: const TextStyle(
                                            color: AppColors.bodyTextColor,
                                            fontSize:
                                                FontSizes.subtitleFontSize,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: comments[index].comment,
                                              style: const TextStyle(
                                                color: AppColors.bodyTextColor,
                                                fontSize:
                                                    FontSizes.subtitleFontSize,
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
