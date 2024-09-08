import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fry_thebird/widgets/bird.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  static double birdY = 0;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -11;
  double velocity = 25;
  double birdWidth = 0.1;
  double birdHeight = 0.1;
  bool isStarted = false;
  static double barrierX = 1;

  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: isStarted ? jump : startGame,
        child: Container(
          key: _containerKey,
          color: Colors.lightBlue,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Bird(
                    birdY: birdY,
                    birdHeight: birdHeight,
                    birdWidth: birdWidth,
                  ),
                ),
                tapToPlayScreen(isStarted),
                Align(
                  alignment: Alignment(barrierX, 1),
                  child: Container(
                    color: Colors.green,
                    width: 50,
                    height: 200,
                  ),
                ),
                Align(
                  alignment: Alignment(barrierX, -1),
                  child: Container(
                    color: Colors.green,
                    width: 50,
                    height: 200,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container tapToPlayScreen(bool isStarted) {
    if (isStarted) {
      return Container();
    }
    return Container(
      alignment: const Alignment(0, -0.5),
      child: const Text(
        "T A P  T O  P L A Y",
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }

  void startGame() {
    isStarted = true;

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPosition - height;
      });

      resetBarrier();

      print(birdY);

      if (!isAlive(birdY)) {
        timer.cancel();
        gameOverDialog();
      }

      time += 0.1;
    });
  }

  void gameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext build) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Center(
            child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: const Text(
                    "P L A Y  A G A I N",
                    // style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      isStarted = false;
      time = 0;
      initialPosition = birdY;
      barrierX = 1;
    });
  }

  void resetBarrier() {
    if (barrierX < -1.3) {
      setState(() {
        barrierX = 1;
      });
    } else {
      barrierX -= 0.05;
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPosition = birdY;
      // print(birdY);
    });
  }

  bool isAlive(double y) {
    if (y > 81.5 || y < -81.5) {
      return false;
    }

    return true;
  }
}
