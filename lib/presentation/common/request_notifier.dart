import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import 'request_state.dart';

abstract class RequestNotifier<Value> with ChangeNotifier {
  RequestNotifier({
    RequestState<Value, Exception> initial = const RequestState.initial(),
  }) : _requestState = initial;

  RequestState<Value, Exception> _requestState;
  bool _mounted = true;

  RequestState<Value, Exception> get state => _requestState;

  // ignore: avoid_setters_without_getters
  set _state(RequestState<Value, Exception> newState) {
    if (newState == _requestState) return;
    _requestState = newState;
    if (_mounted) notifyListeners();
  }

  Future<void> executeRequest(ValueGetter<Future<Value>> requestBuilder) async {
    try {
      _state = _requestState.maybeMap(
        success: (result) => RequestState.loading(resultMaybe: result.value),
        orElse: RequestState<Value, Exception>.loading,
      );

      final value = await requestBuilder();
      _state = RequestState.success(value);
    } catch (e, st) {
      dev.log('[ERROR] ${e.toString()}', error: e, stackTrace: st);
      final exception = (e is Exception) ? e : Exception();
      _state = RequestState.failure(exception);
    }
  }

  void reset() => _state = const RequestState.initial();

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
