import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:word_guesser/presentation/reverse_guess/reverse_guess_page.dart';
import 'package:word_guesser/presentation/word_guess/notifiers/game_mode_provider.dart';

import '../../common/use_init_hook.dart';
import '../../common/widgets/loading_scaffold.dart';
import '../notifiers/word_list_notifier.dart';
import '../word_guess_page.dart';

class WordFetcherWidget extends HookConsumerWidget {
  const WordFetcherWidget({super.key});

  static MaterialPageRoute<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => WordFetcherWidget());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(() => ref.read(wordListProvider.notifier).fetchAllWords());

    final wordListNotifier = ref.watch(wordListProvider);
    final mode = ref.watch(gameModeProvider);
    return wordListNotifier.state.maybeWhen(
      success: (_) {
        switch (mode) {
          case GameMode.discover:
          case GameMode.practice:
            return WordGuessPage();
          case GameMode.reverse:
            return ReverseGuessPage();
        }
      },
      orElse: () => LoadingScaffold(),
    );
  }
}
