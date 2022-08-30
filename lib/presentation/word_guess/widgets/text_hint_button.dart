import 'package:flutter/material.dart';

class TextHintButton extends StatelessWidget {
  final String hint;
  final bool used;
  final VoidCallback? onTapped;

  const TextHintButton({
    required this.hint,
    required this.used,
    this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hintColor = colorScheme.tertiary;
    return TextButton.icon(
      onPressed: used ? null : onTapped,
      icon: used ? const SizedBox.shrink() : const Icon(Icons.edit),
      label: used
          ? Text(
              hint.toUpperCase(),
              style: TextStyle(color: hintColor),
            )
          : const Text('ENGLISH'),
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
          (states) => states.isDisabled
              ? const EdgeInsets.fromLTRB(12, 8, 20, 8)
              : null,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            return states.isDisabled ? BorderSide(color: hintColor) : null;
          },
        ),
      ),
    );
  }
}

extension on Set<MaterialState> {
  bool get isDisabled => contains(MaterialState.disabled);
}
