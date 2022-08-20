import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/loading_scaffold.dart';
import '../common/use_init_hook.dart';
import 'user_notifier.dart';

class AuthWidget extends HookConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitAsync(() => ref.read(userProvider.notifier).signInAnonymously());

    final user = ref.watch(userProvider);
    if (user == null) return LoadingScaffold();
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sample App',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text('with dependencies'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
