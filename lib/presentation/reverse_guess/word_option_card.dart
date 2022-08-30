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

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isIncorrect = useState<bool>(false);
    final isCorrect = useState<bool>(false);

    return InkWell(
      onTap: () {
        if (option.englishWord == correctWord.englishWord) {
          confettiController.play();
          isCorrect.value = true;
        } else {
          isIncorrect.value = true;
        }
        onTapped.call(option.englishWord == correctWord.englishWord);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isIncorrect.value
              ? BorderSide(width: 3, color: colorScheme.error)
              : isCorrect.value
                  ? BorderSide(width: 3, color: Color(0xff05c46b))
                  : BorderSide.none,
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
