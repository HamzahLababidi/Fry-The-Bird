import 'package:flutter/material.dart';
import 'package:fry_thebird/widgets/game.dart';
import 'package:fry_thebird/widgets/score_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Game(),
          ScoreBoard(),
        ],
      ),
    );
  }
}