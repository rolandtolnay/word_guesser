import 'package:riverpod/riverpod.dart';

import '../../../domain/model/word_model.dart';
import '../../common/random_word_provider.dart';
import 'game_mode_provider.dart';

final wordGuessWordProvider =
    StateNotifierProvider<WordGuessWordNotifier, WordModel?>(
  (ref) => WordGuessWordNotifier(ref.read),
);

class WordGuessWordNotifier extends StateNotifier<WordModel?> {
  final Reader _ref;

  WordGuessWordNotifier(this._ref) : super(null);

  void generateRandomWord() {
    switch (_ref(gameModeProvider)) {
      case GameMode.discover:
        state = _ref(randomWordProvider).makeRandomUnguessedWord();
        break;
      case GameMode.practice:
        state = _ref(randomWordProvider).makeRandomGuessedWord();
        break;
      case GameMode.reverse:
        break;
    }
  }
}
