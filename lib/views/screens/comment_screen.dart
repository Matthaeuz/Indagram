import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/state/providers/comments/post_comments_provider.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';
import 'package:indagram/state/providers/users/auth_provider.dart';
import 'package:indagram/views/widgets/comment_item.dart';
import 'package:indagram/views/widgets/loading_overlay.dart';

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen({super.key});

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final postComments = ref.watch(postCommentsProvider);
    final authDetails = ref.watch(authDetailsProvider);
    final post = ref.watch(currentPostProvider);

    return Scaffold(
      backgroundColor: AppColors.bodyColor,
      appBar: AppBar(
        title: const Text(
          'Comments',
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
              if (commentController.text.isNotEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const LoadingOverlay();
                  },
                );
                try {
                  Comment newComment = Comment(
                    commentId: "",
                    userId: authDetails.userId,
                    postId: post.postId,
                    comment: commentController.text,
                    createdAt: Timestamp.fromDate(DateTime.now()),
                  );
                  await FirebaseFirestore.instance
                      .collection('comments')
                      .doc()
                      .set(newComment.toJson());
                  // ignore: unused_result
                  ref.refresh(postCommentsProvider);
                } catch (e) {
                  debugPrint(e.toString());
                } finally {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                  commentController.clear();
                }
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
        child: Column(
          children: [
            Expanded(
              child: postComments.when(data: (comments) {
                if (comments.isNotEmpty) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentItem(
                        index: index,
                        comment: comments.elementAt(index),
                      );
                    },
                  );
                } else {
                  return const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text(
                          AppTexts.noCommentText,
                          style: TextStyle(
                            color: AppColors.noneColor,
                            fontSize: FontSizes.noneFontSize,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }, error: (error, stackTrace) {
                debugPrint('something happened, $error');
                return const CircularProgressIndicator(
                    color: AppColors.bodyTextColor);
              }, loading: () {
                return const CircularProgressIndicator(
                    color: AppColors.bodyTextColor);
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: commentController,
                cursorColor: AppColors.activeFieldColor,
                style: const TextStyle(
                  color: AppColors.appBarFgColor,
                  fontSize: FontSizes.bodyFontSize,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppTexts.commentText,
                  labelStyle: TextStyle(
                    color: AppColors.tabIndicatorColor,
                  ),
                  floatingLabelStyle: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
