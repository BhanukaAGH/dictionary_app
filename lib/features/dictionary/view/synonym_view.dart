import 'package:dictionary_app/features/dictionary/controller/dictionary_controller.dart';
import 'package:dictionary_app/features/dictionary/widgets/word_meaning.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SynonymView extends ConsumerWidget {
  static route(String synonym) => MaterialPageRoute(
        builder: (context) => SynonymView(synonym: synonym),
      );
  final String synonym;
  const SynonymView({super.key, required this.synonym});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(synonym)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 3, 16),
        child: ref.watch(searchWordProvider(synonym)).when(
          data: (data) {
            return WordMeaning(word: data);
          },
          error: (error, stackTrace) {
            if (error is DioException) {
              return const Center(
                child: Text('No Definitions Found'),
              );
            }
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
