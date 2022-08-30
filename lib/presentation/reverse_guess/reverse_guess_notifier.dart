import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/random_word_provider.dart';

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
    final correctWord = _ref(randomWordProvider).makeRandomGuessedWord();
    if (correctWord == null) return;

    final optionList = <WordModel>[];
    while (optionList.length < _optionCount) {
      final option = _ref(randomWordProvider).makeRandomGuessedWord();
      if (option == null) return;
      if (!optionList.map((e) => e.englishWord).contains(option.englishWord) &&
          option.englishWord != correctWord.englishWord) {
        optionList.add(option);
      }
    }
    state = ReverseGuessModel(correctWord: correctWord, options: optionList);
  }
}

class ReverseGuessModel {
  final WordModel correctWord;
  final List<WordModel> options;
  final Iterable<WordModel> allOptions;

  ReverseGuessModel({required this.correctWord, required this.options})
      : allOptions = (options + [correctWord])..shuffle();
}
