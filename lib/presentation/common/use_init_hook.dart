import 'package:flutter_hooks/flutter_hooks.dart';

/// Hook that executes the provided [callback] once.
void useInit(void Function() callback) {
  useEffect(
    () {
      callback();
      return null;
    },
    [],
  );
}

/// Hook that executes the provided [callback] once asynchronously.
void useInitAsync(void Function() callback) {
  useAsyncEffect(
    () async {
      callback();
      return null;
    },
    [],
  );
}

/// Hook that executes the provided [effect] asynchronously.
void useAsyncEffect(Future<Dispose?> Function() effect, [List<Object?>? keys]) {
  useEffect(
    () {
      final disposeFuture = Future.microtask(effect);
      return () => disposeFuture.then((dispose) => dispose?.call());
    },
    keys,
  );
}
