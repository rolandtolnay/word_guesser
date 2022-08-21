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
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.transparent,
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
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 40,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff1e272e)),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: widget.controller.charSimilarityList[i].color,
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
