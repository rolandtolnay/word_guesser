import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../../injectable/injectable.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/english_caption_widget.dart';
import '../common/widgets/loading_scaffold.dart';
import '../common/widgets/wordaroo_confetti.dart';
import 'game_mode_picker_page.dart';
import 'hooks/use_audio_player.dart';
import 'hooks/use_char_input_controller.dart';
import 'hooks/use_confetti_controller.dart';
import 'notifiers/game_mode_provider.dart';
import 'notifiers/guess_count_provider.dart';
import 'notifiers/word_guess_request_notifier.dart';
import 'notifiers/word_guess_word_notifier.dart';
import 'widgets/char_input_widget.dart';

const gameLanguage = 'hu-HU';

class WordGuessPage extends HookConsumerWidget {
  const WordGuessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(
      () => ref.read(wordGuessWordProvider.notifier).generateRandomWord(),
    );

    final word = ref.watch(wordGuessWordProvider);
    if (word == null) return const LoadingScaffold();

    final isWordValid = useState<bool>(false);

    final controller = useCharInputController(expectedWord: word.nativeWord);
    ref.listen<WordModel?>(wordGuessWordProvider, (_, next) {
      if (next != null) controller.updateExpectedWord(next.nativeWord);
    });

    final textToSpeech = useState(getIt<FlutterTts>()).value;
    final focusNode = useFocusNode();
    final confettiController = useConfettiController();
    final audioPlayer = useAudioPlayer();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final hintRow = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () => textToSpeech.speak(word.soundHint),
          icon: const Icon(Icons.volume_up),
          label: const Text('HUNGARIAN'),
        ),
      ],
    );

    final submitButton = ElevatedButton.icon(
      icon: const Icon(Icons.login),
      onPressed: () {
        isWordValid.value = controller.validateWord();
        if (isWordValid.value) {
          ref.read(wordGuessRequestProvider).addGuessedWord(word);
          audioPlayer.play(AssetSource('sounds/reward_sound.wav'));
          confettiController.play();
          HapticFeedback.vibrate();
        } else {
          HapticFeedback.heavyImpact();
        }
      },
      label: const Text('SUBMIT'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => const Size.fromHeight(44),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );

    final nextWordButton = ElevatedButton.icon(
      icon: const Icon(Icons.fast_forward),
      onPressed: () {
        ref.read(wordGuessWordProvider.notifier).generateRandomWord();
        isWordValid.value = false;
      },
      label: const Text('GUESS ANOTHER'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => const Size.fromHeight(44),
        ),
      ),
    );

    final mode = ref.watch(gameModeProvider);
    final count = ref.watch(guessCountProvider);
    final guessCount = Row(
      children: [
        Align(
          alignment: const Alignment(0, 0.7),
          child: Text(
            mode.guessedDescription,
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.tertiary,
            ),
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          Align(
            alignment: const Alignment(0, 0.8),
            child: Text(
              '$count',
              style: textTheme.headline4?.copyWith(
                color: colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]
      ],
    );

    final wordCard = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 120,
            right: MediaQuery.of(context).size.width / 2,
            child: WordarooConfetti(controller: confettiController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 8),
                CachedNetworkImage(
                  imageUrl: word.imageUrl,
                  fit: BoxFit.contain,
                  height: 180,
                  width: 180,
                ),
                const SizedBox(height: 8),
                EnglishCaptionWidget(word: word),
                const SizedBox(height: 24),
                CharInputWidget(
                  controller: controller,
                  focusNode: focusNode,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: guessCount,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
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
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => focusNode.requestFocus(),
                    child: wordCard,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(height: 40, child: hintRow),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Visibility(
                    visible: !isWordValid.value,
                    replacement: nextWordButton,
                    child: submitButton,
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

extension on WordModel {
  String get soundHint => nativeWord;
}
