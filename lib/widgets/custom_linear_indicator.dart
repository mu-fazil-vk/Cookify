import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progress;

  const CustomProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200, // set the total width of the progress indicator
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[200], // set the background color to red
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600), // set the animation duration
            decoration: BoxDecoration(
              color: Constant.baseColor, // set the foreground color to yellow
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width *
                progress /
                6, // calculate the width of the foreground container based on the progress percentage
          ),
        ],
      ),
    );
  }
}
