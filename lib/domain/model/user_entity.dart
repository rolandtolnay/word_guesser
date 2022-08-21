import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

import 'firestore_serializable_annotation.dart';

part 'user_entity.g.dart';

@firestoreSerializable
class UserEntity {
  final String id;
  final String? displayName;

  final List<String> guessedWords;

  UserEntity({
    required this.id,
    this.displayName,
    this.guessedWords = const [],
  });

  UserEntity copyWith({
    String? displayName,
    List<String>? guessedWords,
  }) =>
      UserEntity(
        id: id,
        displayName: displayName ?? this.displayName,
        guessedWords: guessedWords ?? this.guessedWords,
      );
}

@Collection<UserEntity>('users')
final usersRef = UserEntityCollectionReference();
