import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../../../domain/model/word_model.dart';
import '../../auth/user_notifier.dart';
import 'game_mode_provider.dart';
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
    Iterable<WordModel> filtered = wordList;
    switch (_ref(gameModeProvider)) {
      case GameMode.discover:
        filtered = filtered.where(
          (e) => !guessedWords.contains(e.englishWord.toLowerCase()),
        );
        break;
      case GameMode.practice:
        filtered = filtered.where(
          (e) => guessedWords.contains(e.englishWord.toLowerCase()),
        );
        break;
    }

    if (filtered.isEmpty) filtered = wordList;
    // TODO(Roland): Remove length filter after long words supported in UI
    filtered = filtered.where((e) => e.nativeWord.length < 9);
    if (filtered.isEmpty) return;

    state = filtered.toList()[random.nextInt(filtered.length)];
  }
}
