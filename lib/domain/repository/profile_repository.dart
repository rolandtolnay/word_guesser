import 'package:injectable/injectable.dart';

import '../model/user_entity.dart';
import '../model/word_model.dart';

abstract class ProfileRepository {
  Future<void> addGuessedWord(WordModel word, {required UserEntity user});
}

@LazySingleton(as: ProfileRepository)
class FirProfileRepository implements ProfileRepository {
  @override
  Future<void> addGuessedWord(
    WordModel word, {
    required UserEntity user,
  }) async {
    final guessed = user.guessedWords + [word.id];
    final updatedUser = user.copyWith(guessedWords: guessed.unique);
    await usersRef.doc(user.id).set(updatedUser);
  }
}

extension on List<String> {
  List<String> get unique => toSet().toList();
}
