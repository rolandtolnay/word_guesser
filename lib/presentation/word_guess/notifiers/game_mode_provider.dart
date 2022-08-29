import 'package:hooks_riverpod/hooks_riverpod.dart';

enum GameMode {
  discover,
  practice,
  reverse;

  String get guessedDescription {
    switch (this) {
      case GameMode.discover:
        return 'WORDS GUESSED: ';
      case GameMode.practice:
        return 'PRACTICE';
      case GameMode.reverse:
        return 'REVERSE';
    }
  }
}

final gameModeProvider = StateProvider<GameMode>((ref) => GameMode.discover);
