// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../storage/store_data.dart';

class Meals {
  final String name;
  final String category;
  final String id;
  final String image;
  final String instruction;
  final List<String> ingredients;
  final List<String> measure;
  late bool isBookmarked;

  Meals({
    required this.name,
    required this.category,
    required this.id,
    required this.image,
    required this.instruction,
    required this.ingredients,
    required this.measure,
    this.isBookmarked = false,
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    final List<String> ingredients = [];
    final List<String> measure = [];
    for (int i = 1; i <= 20; i++) {
      final ingredientKey = 'strIngredient$i';
      final measureKey = 'strMeasure$i';
      if (json.containsKey(ingredientKey) &&
          json[ingredientKey] != null &&
          json[ingredientKey] != "") {
        ingredients.add(json[ingredientKey]);
        measure.add(json[measureKey]);
      }
    }

    return Meals(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      image: json['strMealThumb'],
      instruction: json['strInstructions'],
      ingredients: ingredients,
      measure: measure,
    );
  }
}

Future<Meals> fetchMealData() async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

  if (response.statusCode == 200) {
    var mealData = Meals.fromJson(jsonDecode(response.body)['meals'][0]);

    // Retrieve bookmarked IDs
    List<String> bookmarkedIds = await getBookmarkedIds().catchError((error) {
      // Handle error
      if (kDebugMode) {
        print('Failed to retrieve bookmarked IDs: $error');
      }
    });

    // Check if meal ID is bookmarked
    bool isBookmarked = bookmarkedIds.contains(mealData.id);

    // Create a new instance of Meals with updated isBookmarked value
    mealData = Meals(
      name: mealData.name,
      category: mealData.category,
      id: mealData.id,
      image: mealData.image,
      instruction: mealData.instruction,
      ingredients: mealData.ingredients,
      measure: mealData.measure,
      isBookmarked: isBookmarked,
    );

    return mealData;
  } else {
    throw Exception('Failed to load meals');
  }
}

Future<List<Meals>?> getMealData(String search) async {
  final response = await http.get(Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$search'));

  if (response.statusCode == 200) {
    final List<Meals> meals = [];
    final jsonList = jsonDecode(response.body)['meals'] as List<dynamic>;

    // ignore: unnecessary_null_comparison
    if (jsonList != null) {
      // Retrieve bookmarked IDs
      List<String> bookmarkedIds = await getBookmarkedIds().catchError((error) {
        // Handle error
        if (kDebugMode) {
          print('Failed to retrieve bookmarked IDs: $error');
        }
      });

      for (final jsonData in jsonList) {
        Meals meal = Meals.fromJson(jsonData);

        // Check if meal ID is bookmarked
        bool isBookmarked = bookmarkedIds.contains(meal.id);

        // Create a new instance of Meals with updated isBookmarked value
        meal = Meals(
          name: meal.name,
          category: meal.category,
          id: meal.id,
          image: meal.image,
          instruction: meal.instruction,
          ingredients: meal.ingredients,
          measure: meal.measure,
          isBookmarked: isBookmarked,
        );

        meals.add(meal);
      }
      return meals;
    } else {
      return null; // Return null if no meals are found
    }
  } else {
    throw Exception('Failed to load meals');
  }
}

Future<Meals> fetchSavedData(String id) async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));

  if (response.statusCode == 200) {
    var mealData = Meals.fromJson(jsonDecode(response.body)['meals'][0]);

    // Retrieve bookmarked IDs
    List<String> bookmarkedIds = await getBookmarkedIds().catchError((error) {
      // Handle error
      if (kDebugMode) {
        print('Failed to retrieve bookmarked IDs: $error');
      }
    });

    // Check if meal ID is bookmarked
    bool isBookmarked = bookmarkedIds.contains(mealData.id);

    // Create a new instance of Meals with updated isBookmarked value
    mealData = Meals(
      name: mealData.name,
      category: mealData.category,
      id: mealData.id,
      image: mealData.image,
      instruction: mealData.instruction,
      ingredients: mealData.ingredients,
      measure: mealData.measure,
      isBookmarked: isBookmarked,
    );

    return mealData;
  } else {
    throw Exception('Failed to load meals');
  }
}