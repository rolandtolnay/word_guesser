import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:injectable/injectable.dart';

import 'firestore_serializable_annotation.dart';

part 'word_model.g.dart';

@firestoreSerializable
class WordModel {
  WordModel(this.id, this.languages, this.imageUrl);

  final String id;
  final Map<String, String> languages;
  final String imageUrl;

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}

@Collection<WordModel>('words')
final wordsRef = WordModelCollectionReference();
