import 'package:injectable/injectable.dart';

import '../model/user_entity.dart';
import '../model/word_model.dart';

abstract class ProfileRepository {
  /// Returns guessed words of the user after adding word
  Future<List<String>> addGuessedWord(
    WordModel word, {
    required UserEntity user,
  });
}

@LazySingleton(as: ProfileRepository)
class FirProfileRepository implements ProfileRepository {
  @override
  Future<List<String>> addGuessedWord(
    WordModel word, {
    required UserEntity user,
  }) async {
    final guessed = user.guessedWords + [word.englishWord];
    final updatedUser = user.copyWith(guessedWords: guessed.unique);
    await usersRef.doc(user.id).set(updatedUser);
    return updatedUser.guessedWords;
  }
}

extension on List<String> {
  List<String> get unique => toSet().toList();
}
