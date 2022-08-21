import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';
import '../../domain/repository/word_repository.dart';
import '../../injectable/injectable.dart';
import '../common/request_notifier.dart';

final wordListProvider = ChangeNotifierProvider(
  (ref) => WordListNotifier(getIt()),
);

class WordListNotifier extends RequestNotifier<List<WordModel>> {
  final WordRepository _wordRepository;

  WordListNotifier(this._wordRepository);

  void fetchAllWords() => executeRequest(_wordRepository.fetchAllWords);
}
