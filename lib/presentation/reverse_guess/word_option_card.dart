import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/widgets/english_caption_widget.dart';
import '../common/widgets/wordaroo_confetti.dart';
import '../word_guess/hooks/use_confetti_controller.dart';

class WordOptionCard extends HookConsumerWidget {
  final WordModel option;
  final WordModel correctWord;

  final void Function(bool) onTapped;

  const WordOptionCard({
    required this.option,
    required this.correctWord,
    required this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confettiController = useConfettiController();
    final state = useState<_CardState>(_CardState.none);

    return InkWell(
      onTap: () {
        if (option.englishWord == correctWord.englishWord) {
          confettiController.play();
          state.value = _CardState.correct;
        } else {
          state.value = _CardState.incorrect;
        }
        onTapped.call(option.englishWord == correctWord.englishWord);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: state.value.buildBorderSide(context),
        ),
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(child: WordarooConfetti(controller: confettiController)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    CachedNetworkImage(
                      imageUrl: option.imageUrl,
                      fit: BoxFit.contain,
                      height: 160,
                      width: 160,
                    ),
                    const SizedBox(height: 8),
                    EnglishCaptionWidget(word: option),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _CardState {
  none,
  correct,
  incorrect;

  BorderSide buildBorderSide(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (this) {
      case _CardState.none:
        return BorderSide.none;
      case _CardState.correct:
        return BorderSide(width: 3, color: Color(0xff05c46b));
      case _CardState.incorrect:
        return BorderSide(width: 3, color: colorScheme.error);
    }
  }
}
