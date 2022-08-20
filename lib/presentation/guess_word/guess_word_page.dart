import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/word_model.dart';

class GuessWordPage extends HookConsumerWidget {
  final WordModel word;

  const GuessWordPage({required this.word, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CachedNetworkImage(imageUrl: word.imageUrl),
      ),
    );
  }
}
