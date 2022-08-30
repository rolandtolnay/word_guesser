import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/use_init_hook.dart';
import '../common/widgets/loading_scaffold.dart';
import '../menu/game_mode_picker_page.dart';
import 'name_input_page.dart';
import 'user_notifier.dart';

class AuthWidget extends HookConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(() => ref.read(userProvider.notifier).signInAnonymously());

    final user = ref.watch(userProvider);
    if (user == null) return const LoadingScaffold();

    return (user.displayName?.isEmpty ?? true)
        ? const NameInputPage()
        : const GameModePickerPage();
  }
}
