import 'package:cooky_recipe/states/bookmark_provider.dart';
import 'package:cooky_recipe/screens/splash_screen.dart';
import 'package:cooky_recipe/states/theme_provider.dart';
import 'package:cooky_recipe/storage/store_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => BookmarkProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        title: 'Cookify',
        theme: themeProvider.themeData,
        home: const SplashScreen(),
      );
    });
  }
}
