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
    return TextButton.icon(
      onPressed: didUseHint.value ? null : () => didUseHint.value = true,
      icon: didUseHint.value ? SizedBox.shrink() : Icon(Icons.edit),
      label: didUseHint.value
          ? Text(
              hint.toUpperCase(),
              style: TextStyle(color: colorScheme.onSurface),
            )
          : Text('ENGLISH'),
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
          (states) => states.isDisabled
              ? const EdgeInsets.fromLTRB(12, 8, 20, 8)
              : null,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.isDisabled ? colorScheme.primary : null,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            return states.isDisabled
                ? BorderSide(color: colorScheme.onSurface)
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
