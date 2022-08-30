import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth/user_notifier.dart';
import '../word_guess/notifiers/game_mode_provider.dart';
import '../word_guess/widgets/word_fetcher_widget.dart';

const _practiceUnlock = kDebugMode ? 0 : 25;
const _reverseUnlock = kDebugMode ? 0 : 50;

class GameModePickerPage extends HookConsumerWidget {
  const GameModePickerPage({super.key});

  static MaterialPageRoute<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const GameModePickerPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final guessedCount = ref.watch(userProvider)?.guessedWords.length ?? 0;
    final practiceEnabled = guessedCount >= _practiceUnlock;
    final reverseEnabled = guessedCount >= _reverseUnlock;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: colorScheme.primary, //change your color her
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Pick a game mode:',
                  style: textTheme.headline3,
                ),
                const SizedBox(height: 32),
                // TODO(Roland): Extract this into widget
                InkWell(
                  onTap: () {
                    ref.read(gameModeProvider.notifier).state =
                        GameMode.discover;
                    Navigator.of(context).pushAndRemoveUntil(
                      WordFetcherWidget.route(),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 160,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(16),
                      color: colorScheme.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.language,
                          color: colorScheme.onPrimary,
                          size: 32,
                        ),
                        Text(
                          'Discover',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.onPrimary),
                        ),
                        Text(
                          'Go on a journey and discover new words',
                          style: TextStyle(color: colorScheme.onPrimary),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: practiceEnabled
                      ? () {
                          ref.read(gameModeProvider.notifier).state =
                              GameMode.practice;
                          Navigator.of(context).pushAndRemoveUntil(
                            WordFetcherWidget.route(),
                            (route) => false,
                          );
                        }
                      : null,
                  child: Container(
                    height: 160,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(16),
                      color: practiceEnabled
                          ? colorScheme.primary
                          : theme.disabledColor,
                    ),
                    child: Row(
                      children: [
                        if (!practiceEnabled) ...[
                          Align(
                            alignment: const Alignment(0, 0.25),
                            child: Icon(
                              Icons.lock,
                              color: colorScheme.onPrimary,
                              size: 36,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.replay,
                              color: colorScheme.onPrimary,
                              size: 32,
                            ),
                            Text(
                              'Practice',
                              style: textTheme.headline1
                                  ?.copyWith(color: colorScheme.onPrimary),
                            ),
                            Text(
                              practiceEnabled
                                  ? 'Practice words you already guessed'
                                  : 'Discover at least $_practiceUnlock words to unlock',
                              style: TextStyle(color: colorScheme.onPrimary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: reverseEnabled
                      ? () {
                          ref.read(gameModeProvider.notifier).state =
                              GameMode.reverse;
                          Navigator.of(context).pushAndRemoveUntil(
                            WordFetcherWidget.route(),
                            (route) => false,
                          );
                        }
                      : null,
                  child: Container(
                    height: 160,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(16),
                      color: reverseEnabled
                          ? colorScheme.primary
                          : theme.disabledColor,
                    ),
                    child: Row(
                      children: [
                        if (!reverseEnabled) ...[
                          Align(
                            alignment: const Alignment(0, 0.25),
                            child: Icon(
                              Icons.lock,
                              color: colorScheme.onPrimary,
                              size: 36,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: colorScheme.onPrimary,
                              size: 32,
                            ),
                            Text(
                              'Reverse',
                              style: textTheme.headline1
                                  ?.copyWith(color: colorScheme.onPrimary),
                            ),
                            Text(
                              practiceEnabled
                                  ? 'Pick the correct image for each word'
                                  : 'Discover at least $_reverseUnlock words to unlock',
                              style: TextStyle(color: colorScheme.onPrimary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
