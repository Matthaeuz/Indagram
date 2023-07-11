// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unused_result

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';
import 'package:indagram/state/providers/comments/post_comments_provider.dart';
import 'package:indagram/state/providers/posts/all_posts_provider.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';
import 'package:indagram/state/providers/posts/post_display_name_provider.dart';
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
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final authDetails = ref.watch(authDetailsProvider);
    final post = ref.watch(currentPostProvider);
    final postComments = ref.watch(postCommentsProvider);
    final posts = ref.watch(allPostsProvider);
    final displayName = ref.watch(displayNameProvider(post.userId));

    debugPrint('${posts.value!.any((p) => p.postId == post.postId)}');

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
                      // ignore: unused_result
                      ref.refresh(allPostsProvider);
                      // ignore: unused_result
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
      // check if post is still contained in posts when posts is rebuilt
      body: !posts.value!.any((p) => p.postId == post.postId)
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
                                        builder: (context) =>
                                            const CommentScreen(),
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
                                  text: '${displayName.value} ',
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
                            post.isCommentAllowed
                                ? postComments.when(data: (comments) {
                                    if (comments.isNotEmpty) {
                                      return ListView.builder(
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
                                              text:
                                                  '${ref.watch(displayNameProvider(comments.elementAt(index).userId)).value} ',
                                              style: const TextStyle(
                                                color: AppColors.bodyTextColor,
                                                fontSize:
                                                    FontSizes.subtitleFontSize,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: comments
                                                      .elementAt(index)
                                                      .comment,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.bodyTextColor,
                                                    fontSize: FontSizes
                                                        .subtitleFontSize,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }, error: (error, stackTrace) {
                                    debugPrint('something happened, $error');
                                    return const CircularProgressIndicator(
                                        color: AppColors.bodyTextColor);
                                  }, loading: () {
                                    return const CircularProgressIndicator(
                                        color: AppColors.bodyTextColor);
                                  })
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
