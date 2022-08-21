import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates a [ConfettiController] that will be disposed automatically.
ConfettiController useConfettiController({
  List<Object?>? keys,
  Duration? duration,
}) {
  return use(_ConfettiControllerHook(keys: keys, duration: duration));
}

class _ConfettiControllerHook extends Hook<ConfettiController> {
  const _ConfettiControllerHook({super.keys, this.duration});

  final Duration? duration;

  @override
  HookState<ConfettiController, Hook<ConfettiController>> createState() =>
      _ConfettiControllerHookState();
}

class _ConfettiControllerHookState
    extends HookState<ConfettiController, _ConfettiControllerHook> {
  late final ConfettiController controller;

  @override
  ConfettiController build(BuildContext context) => controller;

  @override
  void initHook() {
    super.initHook();
    controller = ConfettiController(
      duration: hook.duration ?? const Duration(seconds: 1),
    );
  }

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useConfettiController';
}
