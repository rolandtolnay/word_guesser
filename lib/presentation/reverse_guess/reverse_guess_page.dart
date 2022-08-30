import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/loading_scaffold.dart';
import '../word_guess/game_mode_picker_page.dart';
import '../word_guess/hooks/use_audio_player.dart';
import 'reverse_guess_notifier.dart';
import 'word_option_card.dart';

class ReverseGuessPage extends HookConsumerWidget {
  const ReverseGuessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(
      () => ref.read(reverseGuessProvider.notifier).generateReverseModel(),
    );

    final model = ref.watch(reverseGuessProvider);
    if (model == null) return LoadingScaffold();

    final audioPlayer = useAudioPlayer();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final menuRow = SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              size: 36,
              color: colorScheme.primary,
            ),
            onPressed: () {
              Navigator.of(context).push(
                GameModePickerPage.route(),
              );
            },
          ),
          SizedBox(width: 8),
        ],
      ),
    );
    final optionGrid = GridView.count(
      childAspectRatio: 0.8,
      crossAxisCount: 2,
      children: model.allOptions.map(
        (option) {
          return WordOptionCard(
            key: UniqueKey(),
            option: option,
            correctWord: model.correctWord,
            onTapped: (isCorrect) {
              if (isCorrect) {
                audioPlayer.play(AssetSource('sounds/reward_sound.wav'));
                HapticFeedback.vibrate();
              } else {
                HapticFeedback.heavyImpact();
              }

              Future.delayed(
                Duration(seconds: isCorrect ? 2 : 1),
                () {
                  ref
                      .read(reverseGuessProvider.notifier)
                      .generateReverseModel();
                },
              );
            },
          );
        },
      ).toList(),
    );

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              menuRow,
              Text(
                model.correctWord.nativeWord.toUpperCase(),
                style: textTheme.headline2,
              ),
              const SizedBox(height: 24),
              Expanded(child: optionGrid)
            ],
          ),
        ),
      ),
    );
  }
}
