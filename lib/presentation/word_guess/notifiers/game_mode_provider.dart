import 'package:hooks_riverpod/hooks_riverpod.dart';

enum GameMode { discover, practice }

final gameModeProvider = StateProvider<GameMode>((ref) => GameMode.discover);
