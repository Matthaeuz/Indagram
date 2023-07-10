import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/comment.dart';
import 'package:indagram/views/widgets/comment_item.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    super.key,
    required this.comments,
    required this.addComment,
    required this.deleteComment,
  });

  final List<Comment> comments;
  final Function(Comment) addComment;
  final Function(int) deleteComment;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    comments = List.from(widget.comments);
  }

  void deleteComment2(int index) {
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
            onPressed: () {
              Comment newComment = Comment(
                commentId: "1",
                comment: commentController.text,
              );
              widget.addComment(newComment);
              setState(() {
                comments.add(newComment);
                commentController.clear();
              });
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
              child: comments.isEmpty
                  ? const Column(
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
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return CommentItem(
                          index: index,
                          comment: comments[index],
                          deleteComment: widget.deleteComment,
                          deleteComment2: deleteComment2,
                        );
                      },
                    ),
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
