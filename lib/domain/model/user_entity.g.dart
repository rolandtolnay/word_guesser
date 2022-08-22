// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class UserEntityCollectionReference
    implements
        UserEntityQuery,
        FirestoreCollectionReference<UserEntity, UserEntityQuerySnapshot> {
  factory UserEntityCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$UserEntityCollectionReference;

  static UserEntity fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$UserEntityFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    UserEntity value,
    SetOptions? options,
  ) {
    return _$UserEntityToJson(value);
  }

  @override
  CollectionReference<UserEntity> get reference;

  @override
  UserEntityDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<UserEntityDocumentReference> add(UserEntity value);
}

class _$UserEntityCollectionReference extends _$UserEntityQuery
    implements UserEntityCollectionReference {
  factory _$UserEntityCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$UserEntityCollectionReference._(
      firestore.collection('users').withConverter(
            fromFirestore: UserEntityCollectionReference.fromFirestore,
            toFirestore: UserEntityCollectionReference.toFirestore,
          ),
    );
  }

  _$UserEntityCollectionReference._(
    CollectionReference<UserEntity> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<UserEntity> get reference =>
      super.reference as CollectionReference<UserEntity>;

  @override
  UserEntityDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return UserEntityDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<UserEntityDocumentReference> add(UserEntity value) {
    return reference.add(value).then((ref) => UserEntityDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$UserEntityCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class UserEntityDocumentReference
    extends FirestoreDocumentReference<UserEntity, UserEntityDocumentSnapshot> {
  factory UserEntityDocumentReference(DocumentReference<UserEntity> reference) =
      _$UserEntityDocumentReference;

  DocumentReference<UserEntity> get reference;

  /// A reference to the [UserEntityCollectionReference] containing this document.
  UserEntityCollectionReference get parent {
    return _$UserEntityCollectionReference(reference.firestore);
  }

  @override
  Stream<UserEntityDocumentSnapshot> snapshots();

  @override
  Future<UserEntityDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String id,
    String? displayName,
    DateTime createdAt,
    List<String> guessedWords,
  });

  Future<void> set(UserEntity value);
}

class _$UserEntityDocumentReference
    extends FirestoreDocumentReference<UserEntity, UserEntityDocumentSnapshot>
    implements UserEntityDocumentReference {
  _$UserEntityDocumentReference(this.reference);

  @override
  final DocumentReference<UserEntity> reference;

  /// A reference to the [UserEntityCollectionReference] containing this document.
  UserEntityCollectionReference get parent {
    return _$UserEntityCollectionReference(reference.firestore);
  }

  @override
  Stream<UserEntityDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return UserEntityDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<UserEntityDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return UserEntityDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<void> delete() {
    return reference.delete();
  }

  Future<void> update({
    Object? id = _sentinel,
    Object? displayName = _sentinel,
    Object? createdAt = _sentinel,
    Object? guessedWords = _sentinel,
  }) async {
    final json = {
      if (id != _sentinel) "id": id as String,
      if (displayName != _sentinel) "displayName": displayName as String?,
      if (createdAt != _sentinel) "createdAt": createdAt as DateTime,
      if (guessedWords != _sentinel)
        "guessedWords": guessedWords as List<String>,
    };

    return reference.update(json);
  }

  Future<void> set(UserEntity value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is UserEntityDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class UserEntityDocumentSnapshot extends FirestoreDocumentSnapshot<UserEntity> {
  UserEntityDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<UserEntity> snapshot;

  @override
  UserEntityDocumentReference get reference {
    return UserEntityDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final UserEntity? data;
}

abstract class UserEntityQuery
    implements QueryReference<UserEntity, UserEntityQuerySnapshot> {
  @override
  UserEntityQuery limit(int limit);

  @override
  UserEntityQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  UserEntityQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  UserEntityQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  UserEntityQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  UserEntityQuery whereId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  UserEntityQuery whereDisplayName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  UserEntityQuery whereCreatedAt({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime>? whereIn,
    List<DateTime>? whereNotIn,
  });
  UserEntityQuery whereGuessedWords({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    String? arrayContains,
    List<String>? arrayContainsAny,
  });

  UserEntityQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  });

  UserEntityQuery orderById({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  });

  UserEntityQuery orderByDisplayName({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  });

  UserEntityQuery orderByCreatedAt({
    bool descending = false,
    DateTime startAt,
    DateTime startAfter,
    DateTime endAt,
    DateTime endBefore,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  });

  UserEntityQuery orderByGuessedWords({
    bool descending = false,
    List<String> startAt,
    List<String> startAfter,
    List<String> endAt,
    List<String> endBefore,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  });
}

class _$UserEntityQuery
    extends QueryReference<UserEntity, UserEntityQuerySnapshot>
    implements UserEntityQuery {
  _$UserEntityQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<UserEntity> reference;

  UserEntityQuerySnapshot _decodeSnapshot(
    QuerySnapshot<UserEntity> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return UserEntityQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<UserEntityDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: UserEntityDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return UserEntityQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<UserEntityQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<UserEntityQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  UserEntityQuery limit(int limit) {
    return _$UserEntityQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  UserEntityQuery limitToLast(int limit) {
    return _$UserEntityQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  UserEntityQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(fieldPath, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$UserEntityQuery(query, _collection);
  }

  UserEntityQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$UserEntityQuery(
      reference.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      _collection,
    );
  }

  UserEntityQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$UserEntityQuery(
      reference.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  UserEntityQuery whereId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$UserEntityQuery(
      reference.where(
        _$UserEntityFieldMap["id"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  UserEntityQuery whereDisplayName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$UserEntityQuery(
      reference.where(
        _$UserEntityFieldMap["displayName"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  UserEntityQuery whereCreatedAt({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime>? whereIn,
    List<DateTime>? whereNotIn,
  }) {
    return _$UserEntityQuery(
      reference.where(
        _$UserEntityFieldMap["createdAt"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  UserEntityQuery whereGuessedWords({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    String? arrayContains,
    List<String>? arrayContainsAny,
  }) {
    return _$UserEntityQuery(
      reference.where(
        _$UserEntityFieldMap["guessedWords"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
      ),
      _collection,
    );
  }

  UserEntityQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(FieldPath.documentId, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$UserEntityQuery(query, _collection);
  }

  UserEntityQuery orderById({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$UserEntityFieldMap["id"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$UserEntityQuery(query, _collection);
  }

  UserEntityQuery orderByDisplayName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$UserEntityFieldMap["displayName"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$UserEntityQuery(query, _collection);
  }

  UserEntityQuery orderByCreatedAt({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$UserEntityFieldMap["createdAt"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$UserEntityQuery(query, _collection);
  }

  UserEntityQuery orderByGuessedWords({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    UserEntityDocumentSnapshot? startAtDocument,
    UserEntityDocumentSnapshot? endAtDocument,
    UserEntityDocumentSnapshot? endBeforeDocument,
    UserEntityDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$UserEntityFieldMap["guessedWords"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$UserEntityQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$UserEntityQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class UserEntityQuerySnapshot extends FirestoreQuerySnapshot<UserEntity,
    UserEntityQueryDocumentSnapshot> {
  UserEntityQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<UserEntity> snapshot;

  @override
  final List<UserEntityQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<UserEntityDocumentSnapshot>> docChanges;
}

class UserEntityQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<UserEntity>
    implements UserEntityDocumentSnapshot {
  UserEntityQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<UserEntity> snapshot;

  @override
  UserEntityDocumentReference get reference {
    return UserEntityDocumentReference(snapshot.reference);
  }

  @override
  final UserEntity data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as String,
      displayName: json['displayName'] as String?,
      guessedWords: (json['guessedWords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const FirestoreDateTimeConverter().fromJson),
    );

const _$UserEntityFieldMap = <String, String>{
  'id': 'id',
  'displayName': 'displayName',
  'createdAt': 'createdAt',
  'guessedWords': 'guessedWords',
};

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'createdAt':
          const FirestoreDateTimeConverter().toJson(instance.createdAt),
      'guessedWords': instance.guessedWords,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
