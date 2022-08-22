import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

import 'firestore_serializable_annotation.dart';

part 'user_entity.g.dart';

typedef EnglishTranslation = String;

@firestoreSerializable
class UserEntity {
  final String id;
  final String? displayName;
  final DateTime createdAt;

  final List<EnglishTranslation> guessedWords;

  UserEntity({
    required this.id,
    this.displayName,
    this.guessedWords = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  UserEntity copyWith({
    String? displayName,
    List<String>? guessedWords,
  }) =>
      UserEntity(
        id: id,
        displayName: displayName ?? this.displayName,
        guessedWords: guessedWords ?? this.guessedWords,
        createdAt: createdAt,
      );
}

@Collection<UserEntity>('users')
final usersRef = UserEntityCollectionReference();
