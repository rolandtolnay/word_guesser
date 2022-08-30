import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../auth/user_notifier.dart';
import '../word_guess/notifiers/word_list_notifier.dart';

final randomWordProvider = Provider<RandomWordProvider>(
  (ref) => RandomWordProvider(ref.read),
);

class RandomWordProvider {
  final Reader _ref;
  final _random = Random();

  RandomWordProvider(this._ref);

  WordModel? makeRandomUnguessedWord() => _makeRandomWord(_unguessedWords);

  WordModel? makeRandomGuessedWord() => _makeRandomWord(_guessedWords);

  WordModel? _makeRandomWord(Iterable<WordModel> wordList) {
    // TODO(Roland): Remove length filter after long words supported in UI
    final filtered = wordList.where((e) => e.nativeWord.length < 9);
    if (filtered.isEmpty) return null;
    return filtered.toList()[_random.nextInt(filtered.length)];
  }

  Iterable<WordModel> get _unguessedWords {
    final guessedEnglish = _ref(userProvider)?.guessedWords ?? [];
    return _allWords.where((e) => !guessedEnglish.contains(e.englishWord));
  }

  Iterable<WordModel> get _guessedWords {
    final guessedEnglish = _ref(userProvider)?.guessedWords ?? [];
    return _allWords.where((e) => guessedEnglish.contains(e.englishWord));
  }

  Iterable<WordModel> get _allWords => _ref(wordListProvider).state.maybeWhen(
        success: (wordList) => wordList,
        orElse: () => <WordModel>[],
      );
}
