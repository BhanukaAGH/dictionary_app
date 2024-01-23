import 'package:dictionary_app/features/dictionary/controller/dictionary_controller.dart';
import 'package:dictionary_app/features/dictionary/widgets/word_meaning.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryView extends ConsumerWidget {
  final String keyword;
  final bool isSearchWord;
  const DictionaryView({
    super.key,
    required this.keyword,
    required this.isSearchWord,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 3, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSearchWord && keyword.isNotEmpty
                ? ref.watch(searchWordProvider(keyword)).when(
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
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
