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
// Function to add a bookmarked ID
Future<void> setTheme(String selectedTheme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve existing bookmarked IDs
  String theme = prefs.getString('theme') ?? '';

  if (theme == selectedTheme) {
    return;
  } else {
    // Add the new ID to the list
    theme = selectedTheme;

    // Save the updated list back to shared_preferences
    await prefs.setString('theme', theme);
  }
}

// Function to get all bookmarked IDs
Future<String> getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve bookmarked IDs
  String theme = prefs.getString('theme') ?? 'light';

  return theme;
}
