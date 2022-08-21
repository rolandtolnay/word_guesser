import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/user_notifier.dart';
import 'word_list_notifier.dart';

final guessCountProvider = Provider<String>((ref) {
  final guessedWords = ref.watch(userProvider)?.guessedWords.length ?? 0;
  final totalWords = ref.watch(wordListProvider).state.maybeWhen(
        success: (wordList) => wordList.length,
        orElse: () => 0,
      );

  return '$guessedWords / $totalWords';
});
