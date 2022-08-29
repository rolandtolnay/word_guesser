import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

import '../../presentation/word_guess/word_guess_page.dart';
import 'firestore_serializable_annotation.dart';

part 'word_model.g.dart';

@firestoreSerializable
class WordModel {
  WordModel(this.id, this.translations, this.imageUrl);

  final String id;
  final Map<String, String> translations;
  final String imageUrl;

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}

extension Convenience on WordModel {
  String get nativeWord => (translations[gameLanguage] ?? '').toLowerCase();

  String get englishWord => (translations['en-EN'] ?? '').toLowerCase();
}

@Collection<WordModel>('words')
final wordsRef = WordModelCollectionReference();
