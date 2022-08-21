import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/model/word_model.dart';
import '../../common/use_init_hook.dart';
import '../../common/widgets/loading_scaffold.dart';
import '../word_guess_page.dart';
import '../word_list_notifier.dart';

class WordFetcherWidget extends HookConsumerWidget {
  const WordFetcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(() => ref.read(wordListProvider.notifier).fetchAllWords());

    final wordListNotifier = ref.watch(wordListProvider);
    return wordListNotifier.state.maybeWhen(
      success: (wordList) => WordGuessPage(word: wordList.randomWord),
      orElse: () => LoadingScaffold(),
    );
  }
}

extension on List<WordModel> {
  WordModel get randomWord {
    final random = Random();
    final filtered = where((e) => e.languages[wordLanguage]!.length > 3);
    return filtered.toList()[random.nextInt(filtered.length)];
  }
}
