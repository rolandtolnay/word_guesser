// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

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
abstract class WordModelCollectionReference
    implements
        WordModelQuery,
        FirestoreCollectionReference<WordModel, WordModelQuerySnapshot> {
  factory WordModelCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$WordModelCollectionReference;

  static WordModel fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return WordModel.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    WordModel value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<WordModel> get reference;

  @override
  WordModelDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<WordModelDocumentReference> add(WordModel value);
}

class _$WordModelCollectionReference extends _$WordModelQuery
    implements WordModelCollectionReference {
  factory _$WordModelCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$WordModelCollectionReference._(
      firestore.collection('words').withConverter(
            fromFirestore: WordModelCollectionReference.fromFirestore,
            toFirestore: WordModelCollectionReference.toFirestore,
          ),
    );
  }

  _$WordModelCollectionReference._(
    CollectionReference<WordModel> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<WordModel> get reference =>
      super.reference as CollectionReference<WordModel>;

  @override
  WordModelDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return WordModelDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<WordModelDocumentReference> add(WordModel value) {
    return reference.add(value).then((ref) => WordModelDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$WordModelCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class WordModelDocumentReference
    extends FirestoreDocumentReference<WordModel, WordModelDocumentSnapshot> {
  factory WordModelDocumentReference(DocumentReference<WordModel> reference) =
      _$WordModelDocumentReference;

  DocumentReference<WordModel> get reference;

  /// A reference to the [WordModelCollectionReference] containing this document.
  WordModelCollectionReference get parent {
    return _$WordModelCollectionReference(reference.firestore);
  }

  @override
  Stream<WordModelDocumentSnapshot> snapshots();

  @override
  Future<WordModelDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String id,
    String imageUrl,
  });

  Future<void> set(WordModel value);
}

class _$WordModelDocumentReference
    extends FirestoreDocumentReference<WordModel, WordModelDocumentSnapshot>
    implements WordModelDocumentReference {
  _$WordModelDocumentReference(this.reference);

  @override
  final DocumentReference<WordModel> reference;

  /// A reference to the [WordModelCollectionReference] containing this document.
  WordModelCollectionReference get parent {
    return _$WordModelCollectionReference(reference.firestore);
  }

  @override
  Stream<WordModelDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return WordModelDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<WordModelDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return WordModelDocumentSnapshot._(
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
    Object? imageUrl = _sentinel,
  }) async {
    final json = {
      if (id != _sentinel) "id": id as String,
      if (imageUrl != _sentinel) "imageUrl": imageUrl as String,
    };

    return reference.update(json);
  }

  Future<void> set(WordModel value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is WordModelDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class WordModelDocumentSnapshot extends FirestoreDocumentSnapshot<WordModel> {
  WordModelDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<WordModel> snapshot;

  @override
  WordModelDocumentReference get reference {
    return WordModelDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final WordModel? data;
}

abstract class WordModelQuery
    implements QueryReference<WordModel, WordModelQuerySnapshot> {
  @override
  WordModelQuery limit(int limit);

  @override
  WordModelQuery limitToLast(int limit);

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
  WordModelQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
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
  WordModelQuery whereFieldPath(
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

  WordModelQuery whereDocumentId({
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
  WordModelQuery whereId({
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
  WordModelQuery whereImageUrl({
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

  WordModelQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
  });

  WordModelQuery orderById({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
  });

  WordModelQuery orderByImageUrl({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
  });
}

class _$WordModelQuery extends QueryReference<WordModel, WordModelQuerySnapshot>
    implements WordModelQuery {
  _$WordModelQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<WordModel> reference;

  WordModelQuerySnapshot _decodeSnapshot(
    QuerySnapshot<WordModel> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return WordModelQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<WordModelDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: WordModelDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return WordModelQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<WordModelQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<WordModelQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  WordModelQuery limit(int limit) {
    return _$WordModelQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  WordModelQuery limitToLast(int limit) {
    return _$WordModelQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  WordModelQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
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

    return _$WordModelQuery(query, _collection);
  }

  WordModelQuery whereFieldPath(
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
    return _$WordModelQuery(
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

  WordModelQuery whereDocumentId({
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
    return _$WordModelQuery(
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

  WordModelQuery whereId({
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
    return _$WordModelQuery(
      reference.where(
        _$WordModelFieldMap["id"]!,
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

  WordModelQuery whereImageUrl({
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
    return _$WordModelQuery(
      reference.where(
        _$WordModelFieldMap["imageUrl"]!,
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

  WordModelQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
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

    return _$WordModelQuery(query, _collection);
  }

  WordModelQuery orderById({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$WordModelFieldMap["id"]!, descending: descending);

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

    return _$WordModelQuery(query, _collection);
  }

  WordModelQuery orderByImageUrl({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    WordModelDocumentSnapshot? startAtDocument,
    WordModelDocumentSnapshot? endAtDocument,
    WordModelDocumentSnapshot? endBeforeDocument,
    WordModelDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$WordModelFieldMap["imageUrl"]!,
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

    return _$WordModelQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$WordModelQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class WordModelQuerySnapshot
    extends FirestoreQuerySnapshot<WordModel, WordModelQueryDocumentSnapshot> {
  WordModelQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<WordModel> snapshot;

  @override
  final List<WordModelQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<WordModelDocumentSnapshot>> docChanges;
}

class WordModelQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<WordModel>
    implements WordModelDocumentSnapshot {
  WordModelQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<WordModel> snapshot;

  @override
  WordModelDocumentReference get reference {
    return WordModelDocumentReference(snapshot.reference);
  }

  @override
  final WordModel data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      json['id'] as String,
      Map<String, String>.from(json['languages'] as Map),
      json['imageUrl'] as String,
    );

const _$WordModelFieldMap = <String, String>{
  'id': 'id',
  'languages': 'languages',
  'imageUrl': 'imageUrl',
};

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'id': instance.id,
      'languages': instance.languages,
      'imageUrl': instance.imageUrl,
    };
