import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/widgets/word_card_widget.dart';
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
      child: WordCardWidget(
        word: option,
        confettiController: confettiController,
        borderSide: state.value.buildBorderSide(context),
        imageSize: 168,
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
        return const BorderSide(width: 3, color: Color(0xff05c46b));
      case _CardState.incorrect:
        return BorderSide(width: 3, color: colorScheme.error);
    }
  }
}
