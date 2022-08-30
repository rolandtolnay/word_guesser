import 'package:flutter/material.dart';

import '../../../domain/model/word_model.dart';

class EnglishCaptionWidget extends StatelessWidget {
  const EnglishCaptionWidget({super.key, required this.word});

  final WordModel word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.tertiary),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          word.englishWord.toUpperCase(),
          style: textTheme.caption,
        ),
      ),
    );
  }
}
