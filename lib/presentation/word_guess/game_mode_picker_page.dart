import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth/user_notifier.dart';
import 'notifiers/game_mode_provider.dart';
import 'widgets/word_fetcher_widget.dart';

const _practiceUnlock = kDebugMode ? 0 : 25;
const _reverseUnlock = kDebugMode ? 0 : 50;

class GameModePickerPage extends HookConsumerWidget {
  const GameModePickerPage({super.key});

  static MaterialPageRoute<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => GameModePickerPage());
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
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(16),
                      color: colorScheme.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    padding: EdgeInsets.all(16),
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
                            alignment: Alignment(0, 0.25),
                            child: Icon(
                              Icons.lock,
                              color: colorScheme.onPrimary,
                              size: 36,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                    padding: EdgeInsets.all(16),
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
                            alignment: Alignment(0, 0.25),
                            child: Icon(
                              Icons.lock,
                              color: colorScheme.onPrimary,
                              size: 36,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Reverse',
                              style: textTheme.headline1
                                  ?.copyWith(color: colorScheme.onPrimary),
                            ),
                            Text(
                              practiceEnabled
                                  ? 'Guess the image for each word'
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
