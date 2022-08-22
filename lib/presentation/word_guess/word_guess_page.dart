import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/loading_scaffold.dart';
import 'hooks/use_char_input_controller.dart';
import 'hooks/use_confetti_controller.dart';
import 'notifiers/current_word_notifier.dart';
import 'notifiers/guess_count_provider.dart';
import 'notifiers/word_guess_notifier.dart';
import 'widgets/char_input_widget.dart';
import 'widgets/text_hint_button.dart';

const gameLanguage = 'hu-HU';

class WordGuessPage extends HookConsumerWidget {
  const WordGuessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(
      () => ref.read(currentWordProvider.notifier).generateRandomWord(),
    );

    final word = ref.watch(currentWordProvider);
    if (word == null) return LoadingScaffold();

    final didTextHint = useState<bool>(false);
    final isWordValid = useState<bool>(false);

    final textToSpeech = useState(FlutterTtsFactory.make()).value;

    final controller = useCharInputController(expectedWord: word.nativeWord);
    final focusNode = useFocusNode();
    final confettiController = useConfettiController();
    final audioPlayer = useState(AudioPlayer()..setVolume(1));

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final hintRow = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        TextHintButton(hint: word.textHint, key: ValueKey(word.textHint)),
        const Spacer(),
        TextButton.icon(
          onPressed: () => textToSpeech.speak(word.soundHint),
          icon: Icon(Icons.volume_up),
          label: Text('HUNGARIAN'),
        ),
        const Spacer(),
      ],
    );

    final checkButton = ElevatedButton.icon(
      icon: Icon(Icons.login),
      onPressed: () {
        isWordValid.value = controller.validateWord();
        if (isWordValid.value) {
          ref.read(wordGuessProvider).addGuessedWord(word);
          audioPlayer.value.play(AssetSource('sounds/reward_sound.wav'));
          confettiController.play();
          HapticFeedback.vibrate();
        } else {
          HapticFeedback.heavyImpact();
        }
      },
      label: Text('SUBMIT'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => Size.fromHeight(44),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );

    final nextWordButton = ElevatedButton.icon(
      icon: Icon(Icons.fast_forward),
      onPressed: () {
        ref.read(currentWordProvider.notifier).generateRandomWord();
        final word = ref.read(currentWordProvider);
        if (word != null) {
          controller.updateExpectedWord(word.nativeWord);
        }
        didTextHint.value = false;
        isWordValid.value = false;
      },
      label: Text('GUESS ANOTHER'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => Size.fromHeight(44),
        ),
      ),
    );

    final guessCount = DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          'GUESSED: ${ref.watch(guessCountProvider)}',
          style: textTheme.caption?.copyWith(
            color: colorScheme.secondary,
          ),
        ),
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
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: guessCount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => focusNode.requestFocus(),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 120,
                            right: MediaQuery.of(context).size.width / 2,
                            child: ConfettiWidget(
                              emissionFrequency: 1,
                              numberOfParticles: 4,
                              minimumSize: const Size(4, 4),
                              maximumSize: const Size(12, 12),
                              confettiController: confettiController,
                              blastDirectionality:
                                  BlastDirectionality.explosive,
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
                              children: [
                                const SizedBox(height: 24),
                                CachedNetworkImage(
                                  imageUrl: word.imageUrl,
                                  fit: BoxFit.contain,
                                  height: 180,
                                  width: 180,
                                ),
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(height: 40, child: hintRow),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Visibility(
                    visible: !isWordValid.value,
                    replacement: nextWordButton,
                    child: checkButton,
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
  String get textHint => translations['en_EN'] ?? 'No hint for this one';

  String get soundHint => nativeWord;
}

extension FlutterTtsFactory on FlutterTts {
  static FlutterTts make() {
    return FlutterTts()
      ..setLanguage(gameLanguage)
      ..setVolume(1)
      ..setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        ],
        IosTextToSpeechAudioMode.voicePrompt,
      );
  }
}
