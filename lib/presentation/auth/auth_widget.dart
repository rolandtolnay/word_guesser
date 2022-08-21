import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/user_entity.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/loading_scaffold.dart';
import '../word_guess/widgets/word_fetcher_widget.dart';
import 'name_input_dialog.dart';
import 'user_notifier.dart';

class AuthWidget extends HookConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(() => ref.read(userProvider.notifier).signInAnonymously());

    final user = ref.watch(userProvider);
    if (user == null) return LoadingScaffold();

    useInitAsync(() => _inputDisplayNameIfNeeded(user, context));

    return WordFetcherWidget();
  }

  void _inputDisplayNameIfNeeded(UserEntity user, BuildContext context) {
    if (user.displayName?.isEmpty ?? true) {
      NameInputDialog.show<void>(context);
    }
  }
}
