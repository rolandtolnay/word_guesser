import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';

class CharInputController extends TextEditingController {
  String expectedWord;

  CharInputController({required this.expectedWord}) {
    _clearSimilarity();
  }

  late List<CharSimilarity> charSimilarityList;

  bool validateWord() {
    final input = text.toLowerCase();
    final expected = expectedWord.toLowerCase();
    for (var i = 0; i < input.length; i++) {
      charSimilarityList[i] = _checkSimilarity(
        input: input[i],
        expected: expected[i],
      );
    }
    notifyListeners();
    return text.toLowerCase() == expectedWord.toLowerCase();
  }

  void updateExpectedWord(String value) {
    expectedWord = value;
    clear();
  }

  @override
  set value(TextEditingValue newValue) {
    _clearSimilarity();
    super.value = newValue;
  }

  @override
  void clear() {
    _clearSimilarity();
    super.clear();
  }

  void _clearSimilarity() {
    charSimilarityList = List.generate(
      expectedWord.length,
      (_) => CharSimilarity.none,
    );
  }

  CharSimilarity _checkSimilarity({
    required String input,
    required String expected,
  }) {
    if (input == expected) return CharSimilarity.exactMatch;
    final group = _similarLetters.firstWhereOrNull(
      (e) => e.contains(input),
    );
    if (group == null) return CharSimilarity.none;
    if (group.contains(expected)) return CharSimilarity.similar;
    return CharSimilarity.none;
  }

  static const List<List<String>> _similarLetters = [
    ['a', 'á', 'à'],
    ['e', 'é', 'è'],
    ['i', 'í', 'ì'],
    ['o', 'ó', 'ò', 'ö', 'ő'],
    ['u', 'ù', 'ú', 'ü', 'ű'],
  ];
}

enum CharSimilarity {
  none,
  similar,
  exactMatch;

  // https://flatuicolors.com/palette/se
  Color? get color {
    switch (this) {
      case CharSimilarity.none:
        return const Color(0xffd2dae2);
      case CharSimilarity.similar:
        return const Color(0xffffc048);
      case CharSimilarity.exactMatch:
        return const Color(0xff05c46b);
    }
  }
}
