import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double birdY;
  final double birdWidth;
  final double birdHeight;

  const Bird({super.key, required this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      height: 75,
      width: 75,
      child: Image.asset(
        'lib/assets/bird.png',
        // width: MediaQuery.of(context).size.height * birdWidth / 2,
        // height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
        // fit: BoxFit.fill,
      ),
    );
  }
}
