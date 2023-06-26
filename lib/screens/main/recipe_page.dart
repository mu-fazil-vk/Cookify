import 'package:cooky_recipe/api/api_fetch.dart';
import 'package:cooky_recipe/constants/constant.dart';
import 'package:cooky_recipe/storage/store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.meal});

  final Meals meal;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool _bookmark = false;

  @override
  void initState() {
    super.initState();
    checkBookmarkStatus();
  }

  void checkBookmarkStatus() async {
    List<String>? bookmarkedIds;
    try {
      bookmarkedIds = await getBookmarkedIds();
    } catch (error) {
      bookmarkedIds = null;
    }

    if (bookmarkedIds != null) {
      setState(() {
        _bookmark = bookmarkedIds!.contains(widget.meal.id);
      });
    } else {
      setState(() {
        _bookmark = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage(
                                  meal.image,
                                ),
                                fit: BoxFit.fitWidth)),
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.width,
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black.withOpacity(0.3),
                          child: const Text(
                            'Cookify',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 80, left: 10),
                  child: Text(
                    meal.name,
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Constant.baseColor),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constant.skipButton),
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
                      child: Text(
                        meal.category,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Constant.baseColor,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, left: 10),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        letterSpacing: 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  height: 135,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: meal.ingredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = meal.ingredients[index];
                      final measure = meal.measure[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constant.skipButton),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.themealdb.com/images/ingredients/$ingredient-small.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              ingredient,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              measure,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    'Instructions',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 10, right: 10),
                      child: Text(
                        meal.instruction,
                        style: const TextStyle(
                            fontSize: 17, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Constant.baseColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Constant.white),
                      child: IconButton(
                        onPressed: () async {
                          if (_bookmark == true) {
                            removeBookmark(meal.id);
                          } else {
                            addBookmark(meal.id);
                          }
                          setState(() {
                            _bookmark = !_bookmark;
                          });
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/bookmark.svg",
                          color:
                              _bookmark ? Constant.baseColor : Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
