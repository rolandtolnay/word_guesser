import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CharInputWidget extends StatefulWidget {
  final String nativeWord;
  final CharInputController controller;

  const CharInputWidget({
    super.key,
    required this.nativeWord,
    required this.controller,
  });

  @override
  State<CharInputWidget> createState() => _CharInputWidgetState();
}

class _CharInputWidgetState extends State<CharInputWidget> {
  final focusNode = FocusNode();

  late List<CharState> charStateList;

  @override
  void initState() {
    super.initState();

    resetCharState();
    focusNode.requestFocus();

    widget.controller.addListener(() {
      setState(() {
        resetCharState();
      });
    });
    widget.controller.onValidateWord.listen((_) {
      final input = widget.controller.text.toLowerCase();
      final word = widget.nativeWord;
      for (var i = 0; i < input.length; i++) {
        if (input[i] == word[i]) {
          charStateList[i] = CharState.correct;
        }
      }
      setState(() {});
    });
  }

  void resetCharState() {
    charStateList = List.generate(
      widget.nativeWord.length,
      (_) => CharState.neutral,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final word = widget.nativeWord;

    final textField = TextFormField(
      focusNode: focusNode,
      controller: widget.controller,
      cursorWidth: 0.01,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      style: TextStyle(
        color: Colors.transparent,
        height: .01,
        fontSize: 0.01,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(word.length)],
      textCapitalization: TextCapitalization.characters,
    );

    return Stack(
      children: [
        textField,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            word.length,
            (i) {
              final input = widget.controller.text;
              final letter = i < input.length ? input[i] : '';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: charStateList[i].color,
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: textTheme.headline6?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CharInputController extends TextEditingController {
  final _validationController = StreamController<bool>.broadcast();

  Stream<bool> get onValidateWord => _validationController.stream;

  void validateWord() {
    _validationController.add(true);
  }
}

enum CharState {
  neutral,
  warm,
  correct;

  Color? get color {
    switch (this) {
      case CharState.neutral:
        return Colors.grey[300];
      case CharState.warm:
        return Colors.green[200];
      case CharState.correct:
        return Colors.green[600];
    }
  }
}
