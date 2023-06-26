import 'package:flutter/material.dart';

class Constant {
  static Color baseColor = const Color(0xff00cfc8);
  static Color secondTextHeadColor = Colors.grey[600]!;
  static Color secondTextColor = Colors.grey[500]!;
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color skipButton = const Color.fromARGB(255, 202, 248, 246);

  static String cookingLvlHead = 'What is your cooking level? 🍚';
  static String cookingLvlDesc = 'Please select your cooking level.';
  static String beginnerHead = 'Beginner';
  static String beginnerDesc =
      'Those who have little to no experience in cooking, these recipes are easy to follow and require basic kitchen tools and techniques.';
  static String intermediateHead = 'Intermediate';
  static String intermediateDesc =
      'For those who have some cooking experience and are comfortable in the kitchen, these recipes provide a bit more challenge and require more advanced techniques.';
  static String advancedHead = 'Advanced';
  static String advancedDesc =
      'Experienced cooks who are up for a challenge, these recipes are complex and require advanced techniques and ingredients.';
  static String profHead = 'Professional';
  static String profDesc =
      'For professional chefs or those who want to take their cooking to the next level, these recipes are complex and may require specialized equipment or hard-to-find ingredients.';
}
