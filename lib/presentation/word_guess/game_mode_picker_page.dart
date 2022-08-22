import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth/user_notifier.dart';
import 'notifiers/game_mode_provider.dart';
import 'widgets/word_fetcher_widget.dart';

class GameModePickerPage extends HookConsumerWidget {
  const GameModePickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final guessedCount = ref.watch(userProvider)?.guessedWords.length ?? 0;
    final practiceEnabled = guessedCount >= 10;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick a game mode:',
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  ref.read(gameModeProvider.notifier).state = GameMode.discover;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<dynamic>(
                      builder: (_) => WordFetcherWidget(),
                    ),
                  );
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.resolveWith(
                    (_) => Size.fromHeight(48),
                  ),
                ),
                child: Text(
                  'DISCOVER',
                  style: textTheme.subtitle1
                      ?.copyWith(color: colorScheme.onPrimary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Go on a journey and discover new words',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: practiceEnabled
                    ? SizedBox.shrink()
                    : Icon(
                        Icons.lock,
                        color: colorScheme.onPrimary,
                      ),
                onPressed: practiceEnabled
                    ? () {
                        ref.read(gameModeProvider.notifier).state =
                            GameMode.practice;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<dynamic>(
                            builder: (_) => WordFetcherWidget(),
                          ),
                        );
                      }
                    : null,
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.resolveWith(
                    (_) => Size.fromHeight(48),
                  ),
                ),
                label: Text(
                  'PRACTICE',
                  style: textTheme.subtitle1
                      ?.copyWith(color: colorScheme.onPrimary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  practiceEnabled
                      ? 'Practice words you already guessed'
                      : 'Discover at least 10 words to unlock',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
