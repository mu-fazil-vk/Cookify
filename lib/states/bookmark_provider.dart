/*                    --Don't REMOVE this portion--
==================================FAZIL_VK================================================
Written and Copyrighted by Fazil vk, https://github.com/mu-fazil-vk
==========================================================================================
*/

import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  bool bmchanges = false;

  void toggleBookmark(change) {
    bmchanges = change;
    notifyListeners();
  }
}
