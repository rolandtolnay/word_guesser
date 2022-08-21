import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../widgets/char_input_controller.dart';

/// Creates a [CharInputController] that will be disposed automatically.
CharInputController useCharInputController({
  required String expectedWord,
  List<Object?>? keys,
}) {
  return use(_CharInputControllerHook(keys: keys, expectedWord: expectedWord));
}

class _CharInputControllerHook extends Hook<CharInputController> {
  const _CharInputControllerHook({super.keys, required this.expectedWord});

  final String expectedWord;

  @override
  HookState<CharInputController, Hook<CharInputController>> createState() =>
      _CharInputControllerHookState();
}

class _CharInputControllerHookState
    extends HookState<CharInputController, _CharInputControllerHook> {
  late final CharInputController controller;

  @override
  CharInputController build(BuildContext context) => controller;

  @override
  void initHook() {
    super.initHook();
    controller = CharInputController(expectedWord: hook.expectedWord);
  }

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useCharInputController';
}
