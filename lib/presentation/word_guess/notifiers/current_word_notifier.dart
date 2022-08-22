import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../../../domain/model/word_model.dart';
import '../../auth/user_notifier.dart';
import 'word_list_notifier.dart';

final currentWordProvider =
    StateNotifierProvider<CurrentWordNotifier, WordModel?>(
  (ref) => CurrentWordNotifier(ref.read),
);

class CurrentWordNotifier extends StateNotifier<WordModel?> {
  final Reader _ref;

  CurrentWordNotifier(this._ref) : super(null);

  void generateRandomWord() {
    final wordList = _ref(wordListProvider).state.maybeWhen(
          success: (wordList) => wordList,
          orElse: () => <WordModel>[],
        );
    final guessedWords = _ref(userProvider)?.guessedWords ?? [];

    final random = Random();
    var filtered = wordList.where((e) => !guessedWords.contains(e.englishWord));
    if (filtered.isEmpty) filtered = wordList;
    // TODO(Roland): Remove length filter after long words supported in UI
    filtered = filtered.where((e) => e.nativeWord.length < 9);

    state = filtered.toList()[random.nextInt(filtered.length)];
  }
}
