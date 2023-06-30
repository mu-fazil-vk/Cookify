import 'package:cooky_recipe/screens/intro/preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../states/theme_provider.dart';
import '../../storage/store_data.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //decoration: const BoxDecoration(
          //  image: DecorationImage(
          //    image: AssetImage('assets/intro_bg.png'), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WELCOME TO",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? Constant.white
                        : Constant.black,
                    fontFamily: 'Poppins',
                    letterSpacing: 2),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "COOKIFY",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Constant.baseColor,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 1.5),
              ),
              Lottie.asset("assets/cooking.json", height: 250),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(180, 0, 207, 200)),
                    child: const SizedBox(),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                      setTheme(themeProvider.isDarkMode ? 'dark' : 'light');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Constant.baseColor),
                      child: themeProvider.isDarkMode
                          ? SvgPicture.asset(
                              "assets/icons/sun.svg",
                              height: 35,
                              width: 35,
                            )
                          : SvgPicture.asset(
                              "assets/icons/moon.svg",
                              height: 35,
                              width: 35,
                              color: Colors.yellow,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(180, 0, 207, 200)),
                    child: const SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreferencesScreen()));
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 150,
                  decoration: BoxDecoration(
                      color: Constant.baseColor,
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                      child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
