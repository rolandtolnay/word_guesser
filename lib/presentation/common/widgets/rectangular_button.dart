import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool enabled;

  const RectangularButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => Size.fromHeight(48),
        ),
      ),
      child: Text(
        title,
        style: textTheme.subtitle1?.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }
}
