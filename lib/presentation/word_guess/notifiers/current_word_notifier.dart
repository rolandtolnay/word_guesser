import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../../../domain/model/word_model.dart';
import '../word_list_notifier.dart';

final currentWordProvider =
    StateNotifierProvider<CurrentWordNotifier, WordModel?>(
  (ref) => CurrentWordNotifier(ref.watch(wordListProvider)),
);

class CurrentWordNotifier extends StateNotifier<WordModel?> {
  final WordListNotifier _wordListNotifier;

  CurrentWordNotifier(this._wordListNotifier) : super(null) {
    _wordListNotifier.state.maybeWhen(
      success: (wordList) => generateRandomWord(),
      orElse: () => null,
    );
  }

  void generateRandomWord() {
    final wordList = _wordListNotifier.state.maybeWhen(
      success: (wordList) => wordList,
      orElse: () => <WordModel>[],
    );

    final random = Random();
    final filtered = wordList.where((e) => e.nativeWord.length > 3);
    if (filtered.isEmpty) state = null;

    state = filtered.toList()[random.nextInt(filtered.length)];
  }
}
