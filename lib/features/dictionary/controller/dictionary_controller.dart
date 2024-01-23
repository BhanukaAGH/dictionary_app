import 'package:dictionary_app/apis/dictionary_api.dart';
import 'package:dictionary_app/models/meaning_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictionaryControllerProvider = StateNotifierProvider((ref) {
  final dictionaryAPI = ref.watch(dictionaryAPIProvider);
  return DictionaryController(dictionaryAPI: dictionaryAPI);
});

final searchWordProvider =
    FutureProvider.family.autoDispose((ref, String keyword) async {
  final dictionaryController = ref.watch(dictionaryControllerProvider.notifier);
  return dictionaryController.searchWord(keyword);
});

class DictionaryController extends StateNotifier<bool> {
  final DictionaryAPI _dictionaryAPI;
  DictionaryController({required DictionaryAPI dictionaryAPI})
      : _dictionaryAPI = dictionaryAPI,
        super(false);

  Future<Word> searchWord(String keyword) async {
    final word = await _dictionaryAPI.searchWord(keyword);
    return word;
  }

  void createBookmark(Word word) {
    _dictionaryAPI.createBookmark(word);
  }
}
