/*                    --Don't REMOVE this portion--
==================================FAZIL_VK================================================
Written and Copyrighted by Fazil vk, https://github.com/mu-fazil-vk
==========================================================================================
*/

import 'package:cooky_recipe/constants/constant.dart';
import 'package:cooky_recipe/screens/intro/intro_screen.dart';
import 'package:cooky_recipe/screens/main/home_nav.dart';
import 'package:cooky_recipe/storage/store_data.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isStarted = false;

  @override
  void initState() {
    fetchIsStarted();
    super.initState();
    getIsStarted().then((value) {
      if (value == true) {
        Future.delayed(const Duration(seconds: 2), () {
          // just delay for showing this slash page clearer because it too fast
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeNavScreen()),
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          // just delay for showing this slash page clearer because it too fast
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const IntroScreen()),
          );
        });
      }
    });
  }

  Future<void> fetchIsStarted() async {
    _isStarted = await getIsStarted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          const SizedBox(),
          Center(
              child: Image.asset(
            'assets/logo.png',
            height: 300,
            width: 300,
            color: Constant.baseColor,
          )),
          const SizedBox(
            height: 60,
            width: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [
                Color(0xff00cfc8),
                Color.fromARGB(255, 255, 3, 238),
                Color.fromARGB(255, 0, 252, 8),
                Color.fromARGB(255, 255, 166, 0)
              ],
            ),
          )
        ],
      ),
    );
  }
}
