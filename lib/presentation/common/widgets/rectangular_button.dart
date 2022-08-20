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
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (_) => Size.fromHeight(44),
        ),
      ),
      child: Text(title),
    );
  }
}
