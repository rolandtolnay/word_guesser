import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:word_guesser/presentation/word_guess/notifiers/game_mode_provider.dart';

import '../../auth/user_notifier.dart';

// TODO(Roland): Clean this up
final guessCountProvider = Provider<int?>((ref) {
  final mode = ref.watch(gameModeProvider);
  if (mode == GameMode.practice) return null;

  final guessedWords = ref.watch(userProvider)?.guessedWords.length ?? 0;
  return guessedWords;
});
