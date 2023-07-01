import 'package:cooky_recipe/screens/main/home_nav.dart';
import 'package:cooky_recipe/storage/store_data.dart';
import 'package:cooky_recipe/widgets/button.dart';
import 'package:cooky_recipe/widgets/selection_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../widgets/custom_linear_indicator.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  late String _theme;

  @override
  initState() {
    super.initState();
    fetchTheme();
  }

  Future<void> fetchTheme() async {
    _theme = await getTheme();
  }

  void goToPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
      _pageController.jumpToPage(pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: _currentPageIndex == 0
              ? Container()
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceInOut);
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: _theme == 'light' ? Constant.black : Constant.white,
                  )),
          //backgroundColor: Constant.white,
          elevation: 0,
          centerTitle: true,
          title: Center(
            child: CustomProgressIndicator(progress: _currentPageIndex + 1),
          )),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CookingLevel(goToPage: goToPage),
                CuisinePreferences(goToPage: goToPage),
                DietaryPreferences(goToPage: goToPage)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CookingLevel extends StatefulWidget {
  final Function(int) goToPage;
  const CookingLevel({super.key, required this.goToPage});

  @override
  State<CookingLevel> createState() => _CookingLevelState();
}

class _CookingLevelState extends State<CookingLevel> {
  int selection = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constant.cookingLvlHead,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                Constant.cookingLvlDesc,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 0.7,
                    color: Constant.secondTextHeadColor),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selection = 1;
                          });
                        },
                        child: longestSelectionContainer(
                            size.width,
                            selection == 1 ? true : false,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Constant.beginnerHead,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.7,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    Constant.beginnerDesc,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.7,
                                        fontFamily: 'Ubuntu',
                                        color: Constant.secondTextColor),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selection = 2;
                            });
                          },
                          child: longestSelectionContainer(
                              size.width,
                              selection == 2 ? true : false,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Constant.intermediateHead,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 0.7,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      Constant.intermediateDesc,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.7,
                                          fontFamily: 'Ubuntu',
                                          color: Constant.secondTextColor),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selection = 3;
                          });
                        },
                        child: longestSelectionContainer(
                            size.width,
                            selection == 3 ? true : false,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Constant.advancedHead,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.7,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    Constant.advancedDesc,
                                    style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 0.7,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold,
                                        color: Constant.secondTextColor),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selection = 4;
                            });
                          },
                          child: longestSelectionContainer(
                              size.width,
                              selection == 4 ? true : false,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Constant.profHead,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 0.7,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      Constant.profDesc,
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 0.7,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.bold,
                                          color: Constant.secondTextColor),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
          child: InkWell(
              onTap: () {
                widget.goToPage(1);
              },
              child: customButton(55, size.width, 'Continue'))),
    );
  }
}

class CuisinePreferences extends StatefulWidget {
  final Function(int) goToPage;
  const CuisinePreferences({super.key, required this.goToPage});

  @override
  State<CuisinePreferences> createState() => _CuisinePreferencesState();
}

class _CuisinePreferencesState extends State<CuisinePreferences> {
  bool india = false;
  bool china = false;
  bool france = false;
  bool italy = false;
  bool japan = false;
  bool korea = false;
  bool mexico = false;
  bool spain = false;
  bool thai = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your cuisine preferences 🍳',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.7,
                fontFamily: 'Poppins',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Select your cuisine preferences for better recommendations or you can skip it.',
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.7,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Constant.secondTextHeadColor),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                india = !india;
                              });
                            },
                            child: selectionContainer(
                                110,
                                100,
                                india == true ? true : false,
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/cuisine/Indian.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Indian',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                china = !china;
                              });
                            },
                            child: selectionContainer(
                                110,
                                100,
                                china == true ? true : false,
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/cuisine/Chinese.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Chinese',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                france = !france;
                              });
                            },
                            child: selectionContainer(
                                110,
                                100,
                                france == true ? true : false,
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/cuisine/French.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'French',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  italy = !italy;
                                });
                              },
                              child: selectionContainer(
                                  110,
                                  100,
                                  italy == true ? true : false,
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/cuisine/Italian.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Italian',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  japan = !japan;
                                });
                              },
                              child: selectionContainer(
                                  110,
                                  100,
                                  japan == true ? true : false,
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/cuisine/Japanese.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Japanese',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  korea = !korea;
                                });
                              },
                              child: selectionContainer(
                                  110,
                                  100,
                                  korea == true ? true : false,
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/cuisine/Korean.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Korean',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mexico = !mexico;
                                });
                              },
                              child: selectionContainer(
                                  110,
                                  100,
                                  mexico == true ? true : false,
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/cuisine/Mexican.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Mexican',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  spain = !spain;
                                });
                              },
                              child: selectionContainer(
                                  110,
                                  100,
                                  spain == true ? true : false,
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/cuisine/Spanish.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Spanish',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  thai = !thai;
                                });
                              },
                              child: selectionContainer(
                                  110,
                                  100,
                                  thai == true ? true : false,
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/cuisine/Thai.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Thai',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () => widget.goToPage(2),
                  child: customSkipButton(55, size.width / 2 - 40, 'Skip')),
              InkWell(
                  onTap: () => widget.goToPage(2),
                  child: customButton(55, size.width / 2 - 40, 'Continue'))
            ],
          )),
    );
  }
}

class DietaryPreferences extends StatefulWidget {
  final Function(int) goToPage;
  const DietaryPreferences({super.key, required this.goToPage});

  @override
  State<DietaryPreferences> createState() => _DietaryPreferencesState();
}

class _DietaryPreferencesState extends State<DietaryPreferences> {
  bool veg = false;
  bool vegan = false;
  bool dairyfree = false;
  bool glutenfree = false;
  bool paleo = false;
  bool rawfood = false;
  bool keto = false;
  bool nutfree = false;
  bool soyfree = false;
  bool peanutfree = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Do you have any dietary preferences? 🥣',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.7,
                fontFamily: 'Poppins',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Select your dietary preferences for better recomendations or yiu can skip it.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7,
                    fontFamily: 'Ubuntu',
                    color: Constant.secondTextHeadColor),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                veg = !veg;
                              });
                            },
                            child: longSelectionContainer(size,
                                "assets/diets/veg.jpg", "Vegetarian", veg),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                vegan = !vegan;
                              });
                            },
                            child: longSelectionContainer(
                                size, "assets/diets/vegan.jpg", "Vegan", vegan),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dairyfree = !dairyfree;
                                });
                              },
                              child: longSelectionContainer(
                                  size,
                                  "assets/diets/dairyfree.jpg",
                                  "Dairy-free",
                                  dairyfree),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  glutenfree = !glutenfree;
                                });
                              },
                              child: longSelectionContainer(
                                  size,
                                  "assets/diets/glutenfree.jpg",
                                  "Gluten-free",
                                  glutenfree),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  paleo = !paleo;
                                });
                              },
                              child: longSelectionContainer(size,
                                  "assets/diets/paleo.jpg", "Paleo", paleo),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  rawfood = !rawfood;
                                });
                              },
                              child: longSelectionContainer(
                                  size,
                                  "assets/diets/rawfood.jpg",
                                  "Raw food",
                                  rawfood),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  keto = !keto;
                                });
                              },
                              child: longSelectionContainer(
                                  size, "assets/diets/keto.jpg", "Keto", keto),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  nutfree = !nutfree;
                                });
                              },
                              child: longSelectionContainer(
                                  size,
                                  "assets/diets/nutfree.jpg",
                                  "Nut-free",
                                  nutfree),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  soyfree = !soyfree;
                                });
                              },
                              child: longSelectionContainer(
                                  size,
                                  "assets/diets/soyfree.jpg",
                                  "Soy-free",
                                  soyfree),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  peanutfree = !peanutfree;
                                });
                              },
                              child: longSelectionContainer(
                                  size,
                                  "assets/diets/peanutfree.jpg",
                                  "Peanut-free",
                                  peanutfree),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    setStarted(true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeNavScreen()));
                  },
                  child: customSkipButton(55, size.width / 2 - 40, 'Skip')),
              InkWell(
                  onTap: () {
                    setStarted(true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeNavScreen()));
                  },
                  child: customButton(55, size.width / 2 - 40, 'Done'))
            ],
          )),
    );
  }
}
