import 'package:cooky_recipe/constants/constant.dart';
import 'package:cooky_recipe/screens/main/bookmark_page.dart';
import 'package:cooky_recipe/screens/main/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../states/theme_provider.dart';
import 'home_page.dart';

class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({Key? key}) : super(key: key);

  @override
  HomeNavScreenState createState() => HomeNavScreenState();
}

class HomeNavScreenState extends State<HomeNavScreen> {
  int _selectedIndex = 0;

  final _pages = [
    const HomePage(),
    const SearchPage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: themeProvider.isDarkMode
                      ? const Color.fromARGB(82, 0, 0, 0)
                      : Constant.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ],
                ),
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Constant.baseColor,
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: Constant.skipButton,
                    color: Colors.black,
                    tabs: [
                      GButton(
                        iconColor: themeProvider.isDarkMode
                            ? Constant.white
                            : Constant.black,
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        iconColor: themeProvider.isDarkMode
                            ? Constant.white
                            : Constant.black,
                        icon: Icons.search,
                        text: 'Search',
                      ),
                      GButton(
                        iconColor: themeProvider.isDarkMode
                            ? Constant.white
                            : Constant.black,
                        icon: Icons.bookmark,
                        text: 'Saved',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                )));
          }),
        ));
  }
}
