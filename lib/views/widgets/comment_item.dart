import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/state/providers/comments/post_comments_provider.dart';
import 'package:indagram/state/providers/posts/post_display_name_provider.dart';
import 'package:indagram/state/providers/users/auth_provider.dart';
import 'package:indagram/views/widgets/custom_dialog.dart';

class CommentItem extends ConsumerWidget {
  const CommentItem({
    super.key,
    required this.index,
    required this.comment,
  });

  final int index;
  final Comment comment;

  Future<dynamic> displayDeleteDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Delete Comment?',
          subtitle: AppTexts.deleteCommentText,
          action: 'Delete',
          onSubmit: () async {
            try {
              await FirebaseFirestore.instance
                  .collection('comments')
                  .doc(comment.commentId)
                  .delete();
              // ignore: unused_result
              ref.refresh(postCommentsProvider);
            } catch (e) {
              debugPrint(e.toString());
            } finally {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authDetails = ref.watch(authDetailsProvider);
    final displayName = ref.watch(displayNameProvider(comment.userId)).value?.value;

    if (displayName != null) {
      return ListTile(
        title: Text(
          '$displayName ',
          style: const TextStyle(
            color: AppColors.appBarFgColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          comment.comment,
          style: const TextStyle(
            color: AppColors.bodyTextColor,
          ),
        ),
        trailing: authDetails.userId == comment.userId
            ? IconButton(
                onPressed: () {
                  displayDeleteDialog(context, ref);
                },
                icon: const Icon(Icons.delete),
                color: AppColors.appBarFgColor,
              )
            : const SizedBox(),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
