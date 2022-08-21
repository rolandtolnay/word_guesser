import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextHintButton extends HookWidget {
  final String hint;

  const TextHintButton({required this.hint, super.key});

  @override
  Widget build(BuildContext context) {
    final didUseHint = useState<bool>(false);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ElevatedButton.icon(
      onPressed: didUseHint.value ? null : () => didUseHint.value = true,
      icon: didUseHint.value ? Icon(Icons.lightbulb_outline) : Icon(Icons.edit),
      label: didUseHint.value ? Text(hint.toUpperCase()) : Text('ENGLISH'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => states.isDisabled ? colorScheme.surface : null,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.isDisabled ? colorScheme.primary : null,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            return states.isDisabled
                ? BorderSide(color: colorScheme.primary)
                : null;
          },
        ),
      ),
    );
  }
}

extension on Set<MaterialState> {
  bool get isDisabled => contains(MaterialState.disabled);
}
