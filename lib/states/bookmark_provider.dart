import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  bool bmchanges = false;

  void toggleBookmark(change) {
    bmchanges = change;
    notifyListeners();
  }
}
