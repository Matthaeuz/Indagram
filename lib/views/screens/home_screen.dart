import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/views/tabs/home_tab.dart';
import 'package:indagram/views/tabs/search_tab.dart';
import 'package:indagram/views/tabs/user_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          backgroundColor: AppColors.appBarColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.film,
                color: AppColors.appBarFgColor,
              ),
            ),
            IconButton(
              onPressed: () {},
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
        body: const TabBarView(
          children: [
            UserTab(),
            SearchTab(),
            HomeTab(),
          ],
        ),
      ),
    );
  }
}
