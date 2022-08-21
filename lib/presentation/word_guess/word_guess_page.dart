import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../common/widgets/loading_scaffold.dart';
import 'current_word_notifier.dart';
import 'widgets/char_input_controller.dart';
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

    final controller = useState<CharInputController>(
      CharInputController(expectedWord: word.nativeWord),
    );

    final hintRow = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        TextHintButton(hint: word.textHint, key: ValueKey(word.textHint)),
        const SizedBox(width: 16),
        ElevatedButton.icon(
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
        isWordValid.value = controller.value.validateWord();
      },
      label: Text('CHECK'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => Size.fromHeight(44),
        ),
      ),
    );

    final nextWordButton = ElevatedButton.icon(
      icon: Icon(Icons.fast_forward),
      onPressed: () {
        ref.read(currentWordProvider.notifier).generateRandomWord();
        final word = ref.read(currentWordProvider);
        if (word != null) {
          controller.value.updateExpectedWord(word.nativeWord);
        }
        didTextHint.value = false;
        isWordValid.value = false;
      },
      label: Text('NEXT WORD'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => Size.fromHeight(44),
        ),
      ),
    );

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Guess the word',
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Align(
                child: CachedNetworkImage(
                  imageUrl: word.imageUrl,
                  fit: BoxFit.contain,
                  height: 180,
                  width: 180,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(height: 40, child: hintRow),
              const SizedBox(height: 40),
              CharInputWidget(controller: controller.value),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Visibility(
                  visible: !isWordValid.value,
                  replacement: nextWordButton,
                  child: checkButton,
                ),
              )
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
