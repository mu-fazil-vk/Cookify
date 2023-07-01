/*                    --Don't REMOVE this portion--
==================================FAZIL_VK================================================
Written and Copyrighted by Fazil vk, https://github.com/mu-fazil-vk
==========================================================================================
*/

import 'package:cooky_recipe/storage/store_data.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeProvider() {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    String theme = await getTheme();
    if (theme == 'light') {
      _isDarkMode = false;
    } else if (theme == 'dark') {
      _isDarkMode = true;
    } else {
      _isDarkMode = false; // Assuming auto should default to false
    }
    notifyListeners();
  }

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
