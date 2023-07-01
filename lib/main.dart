import 'package:cooky_recipe/states/bookmark_provider.dart';
import 'package:cooky_recipe/screens/splash_screen.dart';
import 'package:cooky_recipe/states/theme_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cookify',
        theme: themeProvider.themeData,
        home: const SplashScreen(),
      );
    });
  }
}
