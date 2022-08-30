import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'char_input_controller.dart';

class CharInputWidget extends StatefulWidget {
  final CharInputController controller;
  final FocusNode? focusNode;

  const CharInputWidget({super.key, required this.controller, this.focusNode});

  @override
  State<CharInputWidget> createState() => _CharInputWidgetState();
}

class _CharInputWidgetState extends State<CharInputWidget> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.requestFocus();
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
      focusNode: _focusNode,
      controller: widget.controller,
      cursorWidth: 0.01,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.transparent,
      ),
      style: const TextStyle(
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
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 40,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: i <= input.length
                          ? const Color(0xff1e272e)
                          : const Color(0xff8f9397),
                      width: i == input.length ? 2 : 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: i <= input.length
                        ? widget.controller.charSimilarityList[i].color
                        : const Color(0xffe9edf1),
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: textTheme.headline6,
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
