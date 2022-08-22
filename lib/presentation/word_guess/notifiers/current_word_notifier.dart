import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../../../domain/model/user_entity.dart';
import '../../../domain/model/word_model.dart';
import '../../auth/user_notifier.dart';
import 'word_list_notifier.dart';

final currentWordProvider =
    StateNotifierProvider<CurrentWordNotifier, WordModel?>(
  (ref) => CurrentWordNotifier(
    ref.watch(wordListProvider),
    ref.watch(userProvider),
  ),
);

class CurrentWordNotifier extends StateNotifier<WordModel?> {
  final WordListNotifier _wordListNotifier;
  final UserEntity? _currentUser;

  CurrentWordNotifier(this._wordListNotifier, this._currentUser) : super(null) {
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

    final guessed = _currentUser?.guessedWords ?? [];
    final random = Random();
    var filtered = wordList.where((e) => !guessed.contains(e.id));
    if (filtered.isEmpty) filtered = wordList;
    // TODO(Roland): Remove length filter after long words supported in UI
    filtered = filtered.where((e) => e.nativeWord.length < 9);

    state = filtered.toList()[random.nextInt(filtered.length)];
  }
}
