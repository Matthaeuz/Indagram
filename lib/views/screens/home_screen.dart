// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/views/screens/new_post_screen.dart';
import 'package:indagram/views/tabs/home_tab.dart';
import 'package:indagram/views/tabs/search_tab.dart';
import 'package:indagram/views/tabs/user_tab.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indagram/views/widgets/custom_dialog.dart';
import 'package:indagram/views/widgets/loading_overlay.dart';

final imageProvider = Provider<List<String>>((ref) => []);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  // State<HomeScreen> createState() => _HomeScreenState();
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

final picker = ImagePicker();

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<dynamic> displayLogOutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Log Out',
          subtitle: AppTexts.logOutText,
          action: 'Log out',
          onSubmit: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.bodyColor,
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
                    return const LoadingOverlay();
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
            // Gallery Icon
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const LoadingOverlay();
                  },
                );
                final XFile? imageFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (imageFile == null) {
                  Navigator.of(context).pop();
                  return;
                }
                Navigator.of(context).pop();

                final List<String> images = ref.watch(imageProvider);
                images.add(imageFile.path);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewPostScreen(
                      media: imageFile.path,
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
              onPressed: () {
                displayLogOutDialog(context);
              },
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
        body: const TabBarView(
          children: [
            UserTab(), // not sure if we add const since it is a consumer widget
            SearchTab(),
            HomeTab(),
          ],
        ),
      ),
    );
  }
}
