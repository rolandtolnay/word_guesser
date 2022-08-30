// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_tts/flutter_tts.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../domain/repository/auth_repository.dart' as _i3;
import '../domain/repository/profile_repository.dart' as _i5;
import '../domain/repository/word_repository.dart' as _i6;
import 'injectable.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.AuthRepository>(() => _i3.FirAuthRepository());
  gh.lazySingleton<_i4.FlutterTts>(() => appModule.textToSpeech);
  gh.lazySingleton<_i5.ProfileRepository>(() => _i5.FirProfileRepository());
  gh.lazySingleton<_i6.WordRepository>(() => _i6.FirWordRepository());
  return get;
}

class _$AppModule extends _i7.AppModule {}
