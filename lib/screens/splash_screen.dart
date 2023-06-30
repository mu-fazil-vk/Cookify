import 'package:cooky_recipe/constants/constant.dart';
import 'package:cooky_recipe/screens/intro/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // just delay for showing this slash page clearer because it too fast
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    });
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
