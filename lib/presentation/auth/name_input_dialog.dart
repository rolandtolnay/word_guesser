import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/common_dialog.dart';
import '../common/rectangular_button.dart';
import 'user_notifier.dart';

class NameInputDialog extends HookConsumerWidget {
  const NameInputDialog({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NameInputDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final nameController = useTextEditingController();
    final canSubmit = useState<bool>(false);
    nameController.addListener(() {
      canSubmit.value = nameController.text.isNotEmpty;
    });

    return CommonDialog(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Text('Your name:', style: textTheme.headline4),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              style: textTheme.subtitle1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onChanged: (_) {},
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 120,
              child: RectangularButton(
                title: 'READY',
                enabled: canSubmit.value,
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .updateDisplayName(nameController.text.trim());
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
