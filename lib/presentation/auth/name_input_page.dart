import 'package:flutter/material.dart';

class NameInputPage extends StatelessWidget {
  const NameInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Column(
        children: [
          Text(
            'Hi, welcome to',
            style: textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
