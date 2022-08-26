import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:word_guesser/presentation/word_guess/game_mode_picker_page.dart';
import 'package:word_guesser/presentation/word_guess/notifiers/guess_count_provider.dart';

import '../../domain/model/word_model.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/loading_scaffold.dart';
import 'hooks/use_audio_player.dart';
import 'hooks/use_char_input_controller.dart';
import 'hooks/use_confetti_controller.dart';
import 'notifiers/current_word_notifier.dart';
import 'notifiers/game_mode_provider.dart';
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

    final controller = useCharInputController(expectedWord: word.nativeWord);
    ref.listen<WordModel?>(currentWordProvider, (_, next) {
      if (next != null) controller.updateExpectedWord(next.nativeWord);
    });

    final textToSpeech = useState(FlutterTtsFactory.make()).value;
    final focusNode = useFocusNode();
    final confettiController = useConfettiController();
    final audioPlayer = useAudioPlayer();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final hintRow = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        TextHintButton(
          hint: word.textHint,
          used: didTextHint.value,
          onTapped: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text(
                    "There are no limits to how many hints you can use, but don't get used to it ;)",
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('SHOW HINT'),
                    ),
                  ],
                );
              },
            );
            if (confirm != null && confirm) {
              didTextHint.value = true;
            }
          },
        ),
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
          audioPlayer.play(AssetSource('sounds/reward_sound.wav'));
          confettiController.play();
          HapticFeedback.vibrate();
          didTextHint.value = true;
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

    final mode = ref.watch(gameModeProvider);
    final count = ref.watch(guessCountProvider);
    final guessCount = Row(
      children: [
        Align(
          alignment: Alignment(0, 0.7),
          child: Text(
            mode.guessedDescription,
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.tertiary,
            ),
          ),
        ),
        if (count != null) ...[
          SizedBox(width: 8),
          Align(
            alignment: Alignment(0, 0.8),
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

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: guessCount,
                        ),
                      ),
                      Spacer(),
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
                      SizedBox(width: 8),
                    ],
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
  String get textHint => englishWord;

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

extension on GameMode {
  String get guessedDescription {
    switch (this) {
      case GameMode.discover:
        return 'WORDS GUESSED: ';

      case GameMode.practice:
        return 'PRACTICE';
    }
  }
}
