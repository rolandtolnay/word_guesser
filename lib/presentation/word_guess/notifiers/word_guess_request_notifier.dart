import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/model/user_entity.dart';
import '../../../domain/model/word_model.dart';
import '../../../domain/repository/profile_repository.dart';
import '../../../injectable/injectable.dart';
import '../../auth/user_notifier.dart';
import '../../common/request_notifier.dart';

final wordGuessRequestProvider = ChangeNotifierProvider.autoDispose(
  (ref) => WordGuessRequestNotifier(getIt(), ref.watch(userProvider)),
);

class WordGuessRequestNotifier extends RequestNotifier<List<String>> {
  final ProfileRepository _profileRepository;
  final UserEntity? _user;

  WordGuessRequestNotifier(this._profileRepository, this._user);

  void addGuessedWord(WordModel word) {
    final user = _user;
    if (user == null) return;
    executeRequest(() => _profileRepository.addGuessedWord(word, user: user));
  }
}
