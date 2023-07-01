import 'package:shared_preferences/shared_preferences.dart';

// Function to add a bookmarked ID
Future<void> addBookmark(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve existing bookmarked IDs
  List<String> bookmarkedIds = prefs.getStringList('bookmarkedIds') ?? [];

  if (bookmarkedIds.contains(id)) {
    return;
  } else {
    // Add the new ID to the list
    bookmarkedIds.add(id);

    // Save the updated list back to shared_preferences
    await prefs.setStringList('bookmarkedIds', bookmarkedIds);
  }
}

// Function to remove a bookmarked ID
Future<void> removeBookmark(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve existing bookmarked IDs
  List<String> bookmarkedIds = prefs.getStringList('bookmarkedIds') ?? [];

  // Remove the ID from the list
  bookmarkedIds.remove(id);

  // Save the updated list back to shared_preferences
  await prefs.setStringList('bookmarkedIds', bookmarkedIds);
}

// Function to get all bookmarked IDs
Future<List<String>> getBookmarkedIds() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve bookmarked IDs
  List<String> bookmarkedIds = prefs.getStringList('bookmarkedIds') ?? [];

  return bookmarkedIds;
}

//theme
Future<void> setTheme(String selectedTheme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String theme = prefs.getString('theme') ?? '';

  if (theme == selectedTheme) {
    return;
  } else {
    theme = selectedTheme;

    await prefs.setString('theme', theme);
  }
}

Future<String> getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String theme = prefs.getString('theme') ?? 'light';

  return theme;
}

//already started check
Future<void> setStarted(bool isStarted) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool started = prefs.getBool('started') ?? false;

  if (started == isStarted) {
    return;
  } else {
    started = isStarted;

    await prefs.setBool('started', started);
  }
}

Future<bool> getIsStarted() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isStarted = prefs.getBool('started') ?? false;

  return isStarted;
}
