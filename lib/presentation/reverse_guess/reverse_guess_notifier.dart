import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../../domain/model/word_model.dart';
import '../auth/user_notifier.dart';
import '../word_guess/notifiers/word_list_notifier.dart';

final reverseGuessProvider =
    StateNotifierProvider<ReverseGuessNotifier, ReverseGuessModel?>(
  (ref) => ReverseGuessNotifier(ref.read),
);

const _optionCount = 3;

class ReverseGuessNotifier extends StateNotifier<ReverseGuessModel?> {
  final Reader _ref;
  final random = Random();

  ReverseGuessNotifier(this._ref) : super(null);

  void generateReverseModel() {
    final correctWord = _makeRandomWord();
    if (correctWord == null) return;

    final optionList = <WordModel>[];
    while (optionList.length < _optionCount) {
      final option = _makeRandomWord();
      if (option == null) return;
      if (!optionList.map((e) => e.englishWord).contains(option.englishWord) &&
          option.englishWord != correctWord.englishWord) {
        optionList.add(option);
      }
    }
    state = ReverseGuessModel(correctWord: correctWord, options: optionList);
  }

  // TODO(Roland): Extract this into reusable function
  WordModel? _makeRandomWord() {
    final wordList = _ref(wordListProvider).state.maybeWhen(
          success: (wordList) => wordList,
          orElse: () => <WordModel>[],
        );
    final guessedWords = _ref(userProvider)?.guessedWords ?? [];
    Iterable<WordModel> filtered = wordList;
    filtered = filtered.where(
      (e) => guessedWords.contains(e.englishWord),
    );

    if (filtered.isEmpty) filtered = wordList;
    // TODO(Roland): Remove length filter after long words supported in UI
    filtered = filtered.where((e) => e.nativeWord.length < 9);
    if (filtered.isEmpty) return null;

    return filtered.toList()[random.nextInt(filtered.length)];
  }
}

class ReverseGuessModel {
  final WordModel correctWord;
  final List<WordModel> options;

  ReverseGuessModel({required this.correctWord, required this.options});

  Iterable<WordModel> get allOptions => options + [correctWord]
    ..shuffle();
}
