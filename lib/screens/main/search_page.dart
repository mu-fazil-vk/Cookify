import 'dart:async';

import 'package:cooky_recipe/screens/main/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

import '../../api/api_fetch.dart';
import '../../constants/constant.dart';
import '../../storage/store_data.dart';
import '../../widgets/selection_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Meals> mealData;
  Timer? timer;
  String _theme = 'light';

  @override
  void initState() {
    super.initState();
    fetchTheme();
    mealData = [];
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      fetchMealData().then((meal) {
        if (mounted) {
          setState(() {
            if (mealData.length < 20) {
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

  Future<void> fetchTheme() async {
    _theme = await getTheme();
  }

  bool _isFocused = false;
  bool _isSearched = false;
  bool _notFound = false;
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();
  String searchKeyword = '';
  late List<Meals>? searchedMeal;
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
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isFocused
                            ? Constant.baseColor
                            : const Color.fromARGB(255, 0, 255, 8),
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        setState(() {
                          _isFocused = true;
                        });
                      },
                      onChanged: (value) {
                        // Handle search text changes
                        searchKeyword = value;
                        value == '' ? _isSearched = false : null;
                        value == '' ? _notFound = false : null;
                      },
                      onSubmitted: (value) async {
                        // Handle search submission
                        _isLoading = true;
                        searchedMeal = await getMealData(searchKeyword);
                        setState(() {
                          _isSearched = true;
                          _isLoading = false;
                          _notFound = false;
                        });
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _isFocused = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 12, right: 12),
                child: Text(
                  _isSearched ? 'Results' : 'Suggested',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              _isSearched && searchedMeal != null && !_notFound
                  ? Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            for (var row = 0;
                                row < searchedMeal!.length / 2;
                                row++)
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var i = row * 2;
                                        i < searchedMeal!.length &&
                                            i < row * 2 + 2;
                                        i++)
                                      InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecipePage(
                                                          meal: searchedMeal![
                                                              i]))),
                                          child: homeSelect(searchedMeal![i])),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  : _isSearched && (_notFound || searchedMeal == null)
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Lottie.asset("assets/notfound.json",
                                    height: 250, width: 250),
                                const Text(
                                  'Not Found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
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
                                            i < mealData.length &&
                                                i < row * 2 + 2;
                                            i++)
                                          InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecipePage(
                                                              meal: mealData[
                                                                  i]))),
                                              child: homeSelect(mealData[i])),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
            ],
          ),
          if (_isLoading)
            const Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [
                    Color(0xff00cfc8),
                    Color.fromARGB(255, 255, 3, 238),
                    Color.fromARGB(255, 0, 252, 8),
                    Color.fromARGB(255, 255, 166, 0),
                  ],
                ),
              ),
            ),
        ],
      )),
    );
  }
}
