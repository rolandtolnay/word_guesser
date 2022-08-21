import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import 'widgets/char_input_widget.dart';

const wordLanguage = 'hu_HU';

class WordGuessPage extends HookConsumerWidget {
  final WordModel word;

  const WordGuessPage({required this.word, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final didTextHint = useState<bool>(false);
    final textToSpeech =
        useState<FlutterTts>(FlutterTts()..setLanguage(wordLanguage)).value;

    final hintRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ElevatedButton.icon(
              onPressed: didTextHint.value
                  ? null
                  : () {
                      didTextHint.value = true;
                    },
              icon: Icon(Icons.description),
              label: Text('TEXT HINT'),
            ),
            Visibility(
              visible: didTextHint.value,
              child: Text(
                word.textHint,
                style: textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            textToSpeech.speak(word.soundHint);
          },
          icon: Icon(Icons.volume_up),
          label: Text('SOUND HINT'),
        ),
      ],
    );

    final nativeWord = word.languages[wordLanguage]!;
    final controller = useState<CharInputController>(CharInputController());

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
              CachedNetworkImage(
                imageUrl: word.imageUrl,
                fit: BoxFit.contain,
                height: 240,
                width: 240,
              ),
              const SizedBox(height: 16),
              hintRow,
              const SizedBox(height: 32),
              CharInputWidget(
                nativeWord: nativeWord,
                controller: controller.value,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.login),
                  onPressed: () {
                    controller.value.validateWord();
                  },
                  label: Text('CHECK'),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.resolveWith(
                      (_) => Size.fromHeight(44),
                    ),
                  ),
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

  String get soundHint => languages[wordLanguage] ?? '';
}
