import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/providers/posts/all_posts_provider.dart';
import 'package:indagram/state/providers/posts/current_post_provider.dart';
import 'package:indagram/views/screens/post_details_screen.dart';
import 'package:indagram/views/widgets/video_thumb.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch for status of images
    final posts = ref.watch(allPostsProvider);
    // pass asynchronous iterable into our GridView builder
    return posts.when(data: (posts) {
      if (posts.isNotEmpty) {
        return Container(
          color: AppColors.bodyColor,
          child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            loadingBuilder: (BuildContext context, Widget image,
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
        return Container(
          color: AppColors.bodyColor,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'There are no posts to display.',
            style: TextStyle(
              color: AppColors.bodyTextColor,
              fontSize: FontSizes.bodyFontSize,
            ),
          ),
        );
      }
    }, error: (error, stackTrace) {
      debugPrint('something happened, $error');
      return const CircularProgressIndicator();
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
