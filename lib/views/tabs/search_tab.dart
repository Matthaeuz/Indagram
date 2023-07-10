import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';
import 'package:indagram/views/screens/post_details_screen.dart';
import 'package:indagram/views/widgets/video_thumb.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();
  //temporary state management, test with descriptions here
  List<Post> matchedPosts = [
    // Post(
    //   postId: '1',
    //   media: '',
    //   description: 'description',
    //   isLikeAllowed: true,
    //   isCommentAllowed: true,
    //   isImage: true,
    // ),
    // Post(
    //   postId: '1',
    //   media: '',
    //   description: 'description',
    //   isLikeAllowed: true,
    //   isCommentAllowed: true,
    //   isImage: true,
    // ),
    // Post(
    //   postId: '1',
    //   media: '',
    //   description: 'description',
    //   isLikeAllowed: true,
    //   isCommentAllowed: true,
    //   isImage: true,
    // ),
    // Post(
    //   postId: '1',
    //   media: '',
    //   description: 'description',
    //   isLikeAllowed: true,
    //   isCommentAllowed: true,
    //   isImage: true,
    // ),
    // Post(
    //   postId: '1',
    //   media: '',
    //   description: 'description',
    //   isLikeAllowed: true,
    //   isCommentAllowed: true,
    //   isImage: true,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bodyColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              cursorColor: AppColors.activeFieldColor,
              style: const TextStyle(
                color: AppColors.appBarFgColor,
                fontSize: FontSizes.bodyFontSize,
              ),
              decoration: InputDecoration(
                labelText: AppTexts.searchFieldText,
                labelStyle: const TextStyle(
                  color: AppColors.tabIndicatorColor,
                ),
                floatingLabelStyle: const TextStyle(
                  color: AppColors.activeFieldColor,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.activeFieldColor,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(Icons.clear),
                  color: AppColors.activeFieldColor,
                ),
              ),
            ),
          ),
          matchedPosts.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    AppTexts.noSearchedText,
                    style: TextStyle(
                      color: AppColors.noneColor,
                      fontSize: FontSizes.noneFontSize,
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: matchedPosts.length,
                  itemBuilder: (_, int index) {
                    final post = matchedPosts.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailsScreen(
                              post: post,
                            ),
                          ),
                        );
                      },
                      child: GridTile(
                        child: post.isImage
                            ? Image.file(
                                File(post.media),
                                fit: BoxFit.cover,
                              )
                            : VideoThumb(video: post.media),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
