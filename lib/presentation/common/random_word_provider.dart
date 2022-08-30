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
    if (wordList.isEmpty) return null;
    return wordList.toList()[_random.nextInt(wordList.length)];
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
