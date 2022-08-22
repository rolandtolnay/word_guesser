import 'dart:async';
import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../model/user_entity.dart';
import 'api_exception.dart';

abstract class AuthRepository {
  Future<UserEntity?> get currentUser;

  Stream<UserEntity?> get onUserChanged;

  Future<ApiException?> signInAnonymously();

  Future<ApiException?> updateDisplayName(String name);
}

@LazySingleton(as: AuthRepository)
class FirAuthRepository implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  final _userChangedController = StreamController<UserEntity?>.broadcast();
  StreamSubscription<UserEntityDocumentSnapshot>? _collectionListener;

  FirAuthRepository() {
    _auth.authStateChanges().listen((firUser) async {
      if (firUser == null) {
        _userChangedController.add(null);
        await _collectionListener?.cancel();
        return;
      }

      final user = await currentUser;
      if (user != null) await _listenOnCollectionChanges(user.id);
    });
  }

  @override
  Future<UserEntity?> get currentUser async {
    final firUser = _auth.currentUser;
    if (firUser == null) return Future.value();
    final snap = await usersRef.doc(firUser.uid).get();
    return snap.data;
  }

  @override
  Stream<UserEntity?> get onUserChanged => _userChangedController.stream;

  @override
  Future<ApiException?> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      final firUser = _auth.currentUser;
      if (firUser == null) return ApiException('');

      final user = await currentUser;
      if (user == null) {
        final id = firUser.uid;
        final entity = UserEntity(id: id, displayName: firUser.displayName);
        await usersRef.doc(id).set(entity);
        await _listenOnCollectionChanges(id);
      }

      return null;
    } catch (e, st) {
      dev.log('[ERROR] ${e.toString()}', error: e, stackTrace: st);
      return ApiException('$e');
    }
  }

  @override
  Future<ApiException?> updateDisplayName(String name) async {
    assert(
      _auth.currentUser != null,
      'Current user cannot be null when updating name',
    );
    try {
      await _auth.currentUser?.updateDisplayName(name);

      final user = await currentUser;
      if (user != null) await usersRef.doc(user.id).update(displayName: name);

      return null;
    } catch (e, st) {
      dev.log('[ERROR] ${e.toString()}', error: e, stackTrace: st);
      return ApiException('$e');
    }
  }

  Future<void> _listenOnCollectionChanges(String userId) async {
    await _collectionListener?.cancel();
    _collectionListener = usersRef.doc(userId).snapshots().listen((snap) {
      _userChangedController.add(snap.data);
    });
  }
}
