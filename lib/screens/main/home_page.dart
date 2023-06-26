import 'dart:async';

import 'package:cooky_recipe/api/api_fetch.dart';
import 'package:cooky_recipe/screens/main/recipe_page.dart';
import 'package:cooky_recipe/widgets/selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Meals> mealData;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    mealData = [];
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      fetchMealData().then((meal) {
        if (mounted) {
          setState(() {
            if (mealData.length < 40) {
              mealData.add(meal);
            } else {
              t.cancel();
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                "Cookify",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.9),
              ),
              Lottie.asset("assets/cook.json", height: 50, width: 50),
            ],
          ),
          backgroundColor: Constant.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                for (var row = 0; row < 20; row++)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = row * 2;
                            i < mealData.length && i < row * 2 + 2;
                            i++)
                          InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RecipePage(
                                            meal: mealData[i]
                                          ))),
                              child:  homeSelect(
                                      mealData[i])),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
