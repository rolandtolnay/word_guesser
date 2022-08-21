import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../model/user_entity.dart';
import 'api_exception.dart';

abstract class AuthRepository {
  UserEntity? get currentUser;

  Stream<UserEntity?> get onAuthStateChanged;
  Stream<UserEntity?> get onUserChanged;

  Future<ApiException?> signInAnonymously();

  Future<ApiException?> updateDisplayName(String name);
}

@LazySingleton(as: AuthRepository)
class FirAuthRepository implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  UserEntity? get currentUser {
    final firUser = _auth.currentUser;
    if (firUser == null) return null;
    return UserEntity(id: firUser.uid, displayName: firUser.displayName);
  }

  @override
  Stream<UserEntity?> get onAuthStateChanged {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserEntity(id: user.uid, displayName: user.displayName);
    });
  }

  @override
  Stream<UserEntity?> get onUserChanged {
    return _auth.userChanges().map((user) {
      if (user == null) return null;
      return UserEntity(id: user.uid, displayName: user.displayName);
    });
  }

  @override
  Future<ApiException?> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      if (currentUser != null) {
        await usersRef.doc(currentUser!.id).set(currentUser!);
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
      if (currentUser != null) {
        await usersRef.doc(currentUser!.id).set(currentUser!);
      }
      return null;
    } catch (e, st) {
      dev.log('[ERROR] ${e.toString()}', error: e, stackTrace: st);
      return ApiException('$e');
    }
  }
}
