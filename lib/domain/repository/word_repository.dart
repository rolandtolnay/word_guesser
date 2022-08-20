import 'package:injectable/injectable.dart';

import '../model/word_model.dart';

abstract class WordRepository {
  Future<List<WordModel>> fetchAllWords();
}

@LazySingleton(as: WordRepository)
class FirWordRepository implements WordRepository {
  @override
  Future<List<WordModel>> fetchAllWords() async {
    final snap = await wordsRef.get();
    if (snap.docs.isEmpty) return [];
    return snap.docs.map((e) => e.data).toList();
  }
}
