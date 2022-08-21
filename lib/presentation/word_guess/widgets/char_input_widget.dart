import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'char_input_controller.dart';

class CharInputWidget extends StatefulWidget {
  final CharInputController controller;

  const CharInputWidget({super.key, required this.controller});

  @override
  State<CharInputWidget> createState() => _CharInputWidgetState();
}

class _CharInputWidgetState extends State<CharInputWidget> {
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.requestFocus();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final word = widget.controller.expectedWord;

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
        // TODO(Roland): Consider using Wrap to handle longer words
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
                    color: widget.controller.charSimilarityList[i].color,
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
