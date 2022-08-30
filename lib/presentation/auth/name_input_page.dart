import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/widgets/rectangular_button.dart';
import '../menu/game_mode_picker_page.dart';
import 'user_notifier.dart';

class NameInputPage extends HookConsumerWidget {
  const NameInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final nameController = useTextEditingController();
    useListenable(nameController);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Hi, and welcome to',
                  style: textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Image(image: AssetImage('assets/images/logo_slim.png')),
                const SizedBox(height: 24),
                Text(
                  'Learn a new language. \nOne image at a time.',
                  textAlign: TextAlign.center,
                  style: textTheme.headline6,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      Text('Whats your name?', style: textTheme.headline4),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        style: textTheme.subtitle1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 16),
                      RectangularButton(
                        title: 'NEXT',
                        enabled: nameController.text.isNotEmpty,
                        onPressed: () {
                          ref
                              .read(userProvider.notifier)
                              .updateDisplayName(nameController.text.trim());
                          Navigator.of(context).pushReplacement(
                            GameModePickerPage.route(),
                          );
                        },
                      ),
                      const Spacer(flex: 3)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
