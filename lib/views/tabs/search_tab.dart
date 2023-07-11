import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';
import 'package:indagram/state/providers/search/keyword_provider.dart';
import 'package:indagram/state/providers/search/matched_posts_provider.dart';
import 'package:indagram/views/screens/post_details_screen.dart';
import 'package:indagram/views/widgets/video_thumb.dart';

class SearchTab extends ConsumerStatefulWidget {
  const SearchTab({super.key});

  @override
  ConsumerState<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<SearchTab> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final matchedPosts = ref.watch(matchedPostsProvider);
    return Container(
      color: AppColors.bodyColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                ref.read(keywordProvider.notifier).updateKeyword(value);
              },
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
                    ref.read(keywordProvider.notifier).updateKeyword('');
                  },
                  icon: const Icon(Icons.clear),
                  color: AppColors.activeFieldColor,
                ),
              ),
            ),
          ),
          matchedPosts.when(data: (posts) {
            if (posts.isNotEmpty) {
              return Container(
                color: AppColors.bodyColor,
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (_, int index) {
                      final post = posts.elementAt(index);
                      return InkWell(
                        onTap: () {
                          // set current post in provider
                          ref
                              .read(currentPostProvider.notifier)
                              .updateCurrentPost(post);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PostDetailsScreen(),
                            ),
                          );
                        },
                        child: GridTile(
                          child: post.isImage
                              ? Image.network(
                                  post.media,
                                  fit: BoxFit.cover,
                                  frameBuilder: (_, image, loadingBuilder, __) {
                                    if (loadingBuilder == null) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.bodyTextColor,
                                        ),
                                      );
                                    }
                                    return image;
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget image,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return image;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.bodyTextColor,
                                      ),
                                    );
                                  },
                                )
                              : VideoThumb(video: post.media),
                        ),
                      );
                    }),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  AppTexts.noSearchedText,
                  style: TextStyle(
                    color: AppColors.noneColor,
                    fontSize: FontSizes.noneFontSize,
                  ),
                ),
              );
            }
          }, error: (error, stackTrace) {
            debugPrint('something happened, $error');
            return const CircularProgressIndicator();
          }, loading: () {
            return const CircularProgressIndicator();
          })
        ],
      ),
    );
  }
}

// const Padding(
//                   padding: EdgeInsets.all(40.0),
//                   child: Text(
//                     AppTexts.noSearchedText,
//                     style: TextStyle(
//                       color: AppColors.noneColor,
//                       fontSize: FontSizes.noneFontSize,
//                     ),
//                   ),
//                 )