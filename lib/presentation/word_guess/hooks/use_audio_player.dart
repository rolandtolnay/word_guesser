import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates a [AudioPlayer] that will be disposed automatically.
AudioPlayer useAudioPlayer({List<Object?>? keys}) {
  return use(_AudioPlayerHook(keys: keys));
}

class _AudioPlayerHook extends Hook<AudioPlayer> {
  const _AudioPlayerHook({super.keys});

  @override
  HookState<AudioPlayer, Hook<AudioPlayer>> createState() =>
      _AudioPlayerHookState();
}

class _AudioPlayerHookState extends HookState<AudioPlayer, _AudioPlayerHook> {
  late final AudioPlayer audioPlayer;

  @override
  AudioPlayer build(BuildContext context) => audioPlayer;

  @override
  void initHook() {
    super.initHook();
    audioPlayer = AudioPlayer()..setVolume(1);
  }

  @override
  void dispose() => audioPlayer.dispose();

  @override
  String get debugLabel => 'useAudioPlayer';
}
