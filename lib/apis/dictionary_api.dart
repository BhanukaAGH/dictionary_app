import 'package:dictionary_app/core/core.dart';
import 'package:dictionary_app/models/meaning_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

final dictionaryAPIProvider = Provider((ref) {
  final dio = ref.watch(dioClientProvider);
  final dictionaryBox = ref.watch(dictionaryBoxProvider);
  final bookmarksBox = ref.watch(bookmarksBoxProvider);
  return DictionaryAPI(
    dio: dio,
    dictionaryBox: dictionaryBox,
    bookmarksBox: bookmarksBox,
  );
});

abstract class IDictionaryAPI {
  Future<Word> searchWord(String word);
  void createBookmark(Word word);
}

class DictionaryAPI extends IDictionaryAPI {
  final Dio _dio;
  final Box<Word> _dictionaryBox;
  final Box<Word> _bookmarksBox;
  DictionaryAPI({
    required Dio dio,
    required Box<Word> dictionaryBox,
    required Box<Word> bookmarksBox,
  })  : _dictionaryBox = dictionaryBox,
        _bookmarksBox = bookmarksBox,
        _dio = dio;

  @override
  Future<Word> searchWord(String word) async {
    if (_dictionaryBox.containsKey(word)) {
      return _dictionaryBox.get(word)!;
    } else {
      final res = await _dio.get('/$word');
      _dictionaryBox.put(word, Word.fromJson(res.data[0]));
      return Word.fromJson(res.data[0]);
    }
  }

  @override
  void createBookmark(Word word) {
    if (!_bookmarksBox.containsKey(word.word)) {
      _bookmarksBox.put(word.word, word);
    } else {
      _bookmarksBox.delete(word.word);
    }
  }
}
