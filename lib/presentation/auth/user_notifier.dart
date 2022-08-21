import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injectable/injectable.dart';
import '../../domain/model/user_entity.dart';
import '../../domain/repository/auth_repository.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserEntity?>(
  (ref) => UserNotifier(getIt()),
);

class UserNotifier extends StateNotifier<UserEntity?> {
  final AuthRepository _repository;
  late final StreamSubscription<UserEntity?> _listener;

  UserNotifier(this._repository) : super(null) {
    _listener = _repository.onUserChanged.listen((user) {
      state = user;
    });
  }

  Future<void> signInAnonymously() => _repository.signInAnonymously();

  Future<void> updateDisplayName(String name) async {
    await _repository.updateDisplayName(name);
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }
}
