import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../presentation/word_guess/word_guess_page.dart';
import 'injectable.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => $initGetIt(getIt);

@module
abstract class AppModule {
  @lazySingleton
  FlutterTts get textToSpeech => FlutterTtsFactory.make();
}

extension FlutterTtsFactory on FlutterTts {
  static FlutterTts make() {
    return FlutterTts()
      ..setLanguage(gameLanguage)
      ..setVolume(1)
      ..setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        ],
        IosTextToSpeechAudioMode.voicePrompt,
      );
  }
}
