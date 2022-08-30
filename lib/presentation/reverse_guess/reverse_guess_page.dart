import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/debouncer.dart';
import '../../domain/model/word_model.dart';
import '../../injectable/injectable.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/generic/loading_scaffold.dart';
import '../menu/game_mode_picker_page.dart';
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

    final audioPlayer = useAudioPlayer();
    final textToSpeech = useState(getIt<FlutterTts>()).value;
    final ignoreTaps = useState<bool>(false);
    final sessionWordCount = useState<int>(0);
    final sessionCorrectCount = useState<int>(0);
    final speechDebouncer = useState(Debouncer(Duration(seconds: 1)));

    final model = ref.watch(reverseGuessProvider);
    final isMounted = useIsMounted();
    ref.listen<ReverseGuessModel?>(reverseGuessProvider, (previous, next) {
      if (next == null) return;
      final current = next.correctWord.englishWord;
      final prev = previous?.correctWord.englishWord;
      if (current == prev) return;
      speechDebouncer.value.run(() {
        if (isMounted()) textToSpeech.speak(next.correctWord.nativeWord);
      });
    });

    if (model == null) return const LoadingScaffold();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final scorePercent = sessionWordCount.value > 0
        ? '${(sessionCorrectCount.value / sessionWordCount.value * 100).toInt()}%'
        : '';
    final scoreCount = 'out of ${sessionWordCount.value}';
    final menuRow = SizedBox(
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(width: 8),
          Visibility(
            visible: sessionWordCount.value > 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SESSION SCORE:',
                  style:
                      textTheme.caption?.copyWith(color: colorScheme.tertiary),
                ),
                AnimatedSwitcher(
                  switchInCurve: Curves.easeInExpo,
                  switchOutCurve: Curves.easeOutExpo,
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity:
                          Tween<double>(begin: 0, end: 1).animate(animation),
                      child: child,
                    );
                  },
                  child: SizedBox(
                    key: ValueKey<String>(scorePercent),
                    width: 240,
                    height: 32,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          scorePercent,
                          style: textTheme.headline6?.copyWith(
                            color: colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Align(
                          alignment: Alignment(0, 0.25),
                          child: Text(
                            scoreCount,
                            style: textTheme.caption?.copyWith(
                              color: colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.menu,
              size: 36,
              color: colorScheme.primary,
            ),
            onPressed: () {
              Navigator.of(context).push(GameModePickerPage.route());
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
    final optionGrid = GridView.count(
      childAspectRatio: 0.8,
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      children: model.allOptions.map(
        (option) {
          final key = '${model.correctWord.englishWord}${option.englishWord}';
          return WordOptionCard(
            key: ValueKey(key),
            option: option,
            correctWord: model.correctWord,
            onTapped: (isCorrect) {
              if (isCorrect) {
                audioPlayer.play(AssetSource('sounds/reward_sound.wav'));
                HapticFeedback.vibrate();
                sessionCorrectCount.value += 1;
              } else {
                audioPlayer.play(AssetSource('sounds/incorrect_sound.wav'));
                HapticFeedback.heavyImpact();
              }

              sessionWordCount.value += 1;
              ignoreTaps.value = true;
              Future.delayed(
                Duration(seconds: isCorrect ? 2 : 1),
                () {
                  ignoreTaps.value = false;
                  ref
                      .read(reverseGuessProvider.notifier)
                      .generateReverseModel(previous: model.correctWord);
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
              const SizedBox(height: 24),
              Text(
                model.correctWord.nativeWord.toUpperCase(),
                style: textTheme.headline2,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: IgnorePointer(
                  ignoring: ignoreTaps.value,
                  child: optionGrid,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
