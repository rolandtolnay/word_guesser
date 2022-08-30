import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class WordarooConfetti extends StatelessWidget {
  final ConfettiController controller;

  const WordarooConfetti({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      emissionFrequency: 1,
      numberOfParticles: 4,
      minimumSize: const Size(4, 4),
      maximumSize: const Size(12, 12),
      confettiController: controller,
      blastDirectionality: BlastDirectionality.explosive,
      colors: const <Color>[
        Colors.greenAccent,
        Colors.blue,
        Colors.pink,
        Colors.deepOrange,
        Colors.deepPurpleAccent,
        Colors.purpleAccent,
        Colors.yellow,
        Colors.lightBlueAccent,
      ],
    );
  }
}
