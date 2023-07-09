import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/models/post.dart';
import 'package:indagram/views/screens/new_post_screen.dart';
import 'package:indagram/views/tabs/home_tab.dart';
import 'package:indagram/views/tabs/search_tab.dart';
import 'package:indagram/views/tabs/user_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final picker = ImagePicker();

class _HomeScreenState extends State<HomeScreen> {
  // temporary state management
  List<Post> userPosts = [];

  void addPost(Post newPost) {
    setState(() {
      userPosts = [...userPosts, newPost];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppTexts.appBarText,
            style: TextStyle(
              color: AppColors.appBarFgColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                final XFile? videoFile =
                    await picker.pickVideo(source: ImageSource.gallery);
                if (videoFile == null) {
                  Navigator.of(context).pop();
                  return;
                }
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewPostScreen(
                      media: videoFile.path,
                      addPost: addPost,
                      isImage: false,
                    ),
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.film,
                color: AppColors.appBarFgColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                final XFile? imageFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (imageFile == null) {
                  Navigator.of(context).pop();
                  return;
                }
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewPostScreen(
                      media: imageFile.path,
                      addPost: addPost,
                      isImage: true,
                    ),
                  ),
                );
              },
              icon: const FaIcon(
                Icons.add_photo_alternate_outlined,
                color: AppColors.appBarFgColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                Icons.logout,
                color: AppColors.appBarFgColor,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.search)),
              Tab(icon: Icon(Icons.home)),
            ],
            labelColor: AppColors.appBarFgColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.tabIndicatorColor,
            unselectedLabelColor: AppColors.tabIndicatorColor,
          ),
        ),
        body: TabBarView(
          children: [
            UserTab(posts: userPosts),
            SearchTab(posts: userPosts),
            HomeTab(posts: userPosts),
          ],
        ),
      ),
    );
  }
}
