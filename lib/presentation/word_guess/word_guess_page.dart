import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/widgets/loading_scaffold.dart';
import 'hooks/use_char_input_controller.dart';
import 'hooks/use_confetti_controller.dart';
import 'notifiers/current_word_notifier.dart';
import 'notifiers/guess_count_provider.dart';
import 'notifiers/word_guess_notifier.dart';
import 'widgets/char_input_widget.dart';
import 'widgets/text_hint_button.dart';

// TODO(Roland): Refactor words to use hu-HU and correct tts below
const wordLanguage = 'hu_HU';

class WordGuessPage extends HookConsumerWidget {
  const WordGuessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(currentWordProvider);
    if (word == null) return LoadingScaffold();

    final didTextHint = useState<bool>(false);
    final isWordValid = useState<bool>(false);

    final textToSpeech = useState<FlutterTts>(
      FlutterTts()..setLanguage('hu-HU'),
    ).value;

    final controller = useCharInputController(expectedWord: word.nativeWord);
    final focusNode = useFocusNode();
    final confettiController = useConfettiController();

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
          confettiController.play();
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

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Guess the word!',
                  style: textTheme.headline4,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DecoratedBox(
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () => focusNode.requestFocus(),
                  child: Card(
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
              const SizedBox(height: 24),
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
    );
  }
}

extension on WordModel {
  String get textHint => languages['en_EN'] ?? 'No hint for this one';

  String get soundHint => nativeWord;
}
