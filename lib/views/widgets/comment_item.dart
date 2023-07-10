import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/views/widgets/custom_dialog.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.index,
    required this.comment,
    required this.deleteComment,
    required this.deleteComment2,
  });

  final int index;
  final Comment comment;
  final Function(int) deleteComment;
  final Function(int) deleteComment2;

  Future<dynamic> displayDeleteDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Delete Comment?',
          subtitle: AppTexts.deleteCommentText,
          action: 'Delete',
          onSubmit: () {
            deleteComment(index);
            deleteComment2(index);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'User',
        style: TextStyle(
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
      trailing: IconButton(
        onPressed: () {
          displayDeleteDialog(context);
        },
        icon: const Icon(Icons.delete),
        color: AppColors.appBarFgColor,
      ),
    );
  }
}
