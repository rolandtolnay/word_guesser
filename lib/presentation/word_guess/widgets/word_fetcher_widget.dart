import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/use_init_hook.dart';
import '../../common/widgets/loading_scaffold.dart';
import '../notifiers/word_list_notifier.dart';
import '../word_guess_page.dart';

class WordFetcherWidget extends HookConsumerWidget {
  const WordFetcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(() => ref.read(wordListProvider.notifier).fetchAllWords());

    final wordListNotifier = ref.watch(wordListProvider);
    return wordListNotifier.state.maybeWhen(
      success: (_) => WordGuessPage(),
      orElse: () => LoadingScaffold(),
    );
  }
}
