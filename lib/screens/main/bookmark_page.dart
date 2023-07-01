/*                    --Don't REMOVE this portion--
==================================FAZIL_VK================================================
Written and Copyrighted by Fazil vk, https://github.com/mu-fazil-vk
==========================================================================================
*/

import 'dart:async';
import 'package:cooky_recipe/screens/main/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../api/api_fetch.dart';
import '../../constants/constant.dart';
import '../../storage/store_data.dart';
import '../../widgets/selection_widget.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late List<Meals> mealData;
  Timer? timer;
  String _theme = 'light';

  @override
  void initState() {
    super.initState();
    mealData = [];
    fetchTheme();
    getBookmarkedIds().then((List<dynamic> saved) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (mounted) {
          if (mealData.length < saved.length) {
            final String id = saved[mealData.length];
            fetchSavedData(id).then((meal) {
              if (mounted) {
                setState(() {
                  mealData.add(meal);
                  if (mealData.length >= saved.length) {
                    t.cancel();
                  }
                });
              }
            });
          } else {
            t.cancel();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchTheme() async {
    _theme = await getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Cookify",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _theme == 'light' ? Constant.white : Constant.black,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.9),
              ),
              Lottie.asset("assets/cook.json", height: 50, width: 50),
            ],
          ),
          backgroundColor: Constant.baseColor,
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
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecipePage(meal: mealData[i]))),
                            child: homeSelect(mealData[i])),
                    ],
                  ),
                ),
            ],
          ),
        )));
  }
}
