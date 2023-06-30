import 'package:flutter/material.dart';

import '../constants/constant.dart';

Widget customButton(double height, double width, String text) {
  return Container(
    height: 55,
    width: width,
    decoration: BoxDecoration(
        color: Constant.baseColor, borderRadius: BorderRadius.circular(40)),
    child: Center(
        child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    )),
  );
}

Widget customSkipButton(double height, double width, String text) {
  return Container(
    height: 55,
    width: width,
    decoration: BoxDecoration(
        color: Constant.skipButton, borderRadius: BorderRadius.circular(40)),
    child: Center(
        child: Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(255, 0, 207, 200), fontWeight: FontWeight.bold),
    )),
  );
}
