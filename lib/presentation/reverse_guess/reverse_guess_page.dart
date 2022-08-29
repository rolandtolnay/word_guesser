import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:word_guesser/domain/model/word_model.dart';
import 'package:word_guesser/presentation/reverse_guess/reverse_guess_notifier.dart';

import '../common/use_init_hook.dart';
import '../common/widgets/loading_scaffold.dart';
import '../word_guess/game_mode_picker_page.dart';
import '../word_guess/hooks/use_audio_player.dart';
import '../word_guess/hooks/use_confetti_controller.dart';

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
          return WordOption(
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

class WordOption extends HookConsumerWidget {
  final WordModel option;
  final WordModel correctWord;

  final void Function(bool) onTapped;

  const WordOption({
    required this.option,
    required this.correctWord,
    required this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confettiController = useConfettiController();
    // TODO(Roland): Extract this outside

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final isIncorrect = useState<bool>(false);
    final isCorrect = useState<bool>(false);

    return InkWell(
      onTap: () {
        if (option.englishWord == correctWord.englishWord) {
          confettiController.play();
          isCorrect.value = true;
        } else {
          isIncorrect.value = true;
        }
        onTapped.call(option.englishWord == correctWord.englishWord);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isIncorrect.value
              ? BorderSide(width: 3, color: colorScheme.error)
              : isCorrect.value
                  ? BorderSide(width: 3, color: Color(0xff05c46b))
                  : BorderSide.none,
        ),
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                child: ConfettiWidget(
                  emissionFrequency: 1,
                  numberOfParticles: 4,
                  minimumSize: const Size(4, 4),
                  maximumSize: const Size(12, 12),
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  colors: const <Color>[
                    Colors.greenAccent,
                    Colors.blue,
                    Colors.pink,
                    Colors.deepOrange,
                    Colors.deepPurpleAccent,
                    Colors.purpleAccent,
                    Colors.yellow,
                    Colors.lightBlueAccent,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    CachedNetworkImage(
                      imageUrl: option.imageUrl,
                      fit: BoxFit.contain,
                      height: 160,
                      width: 160,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      option.englishWord,
                      style: textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
