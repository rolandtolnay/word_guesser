import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/word_model.dart';
import '../../word_guess/widgets/char_input_controller.dart';
import '../../word_guess/widgets/char_input_widget.dart';
import 'english_caption_widget.dart';
import 'wordaroo_confetti.dart';

class WordCardWidget extends StatelessWidget {
  final WordModel word;
  final ConfettiController confettiController;
  final double imageSize;
  final BorderSide borderSide;

  final CharInputController? charInputController;
  final FocusNode? focusNode;

  const WordCardWidget({
    super.key,
    required this.word,
    required this.confettiController,
    this.imageSize = 180,
    this.borderSide = BorderSide.none,
    this.charInputController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: borderSide,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(child: WordarooConfetti(controller: confettiController)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                CachedNetworkImage(
                  imageUrl: word.imageUrl,
                  fit: BoxFit.contain,
                  height: imageSize,
                  width: imageSize,
                ),
                const SizedBox(height: 8),
                EnglishCaptionWidget(word: word),
                if (charInputController != null) ...[
                  const SizedBox(height: 24),
                  CharInputWidget(
                    controller: charInputController!,
                    focusNode: focusNode,
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
