import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/models/meaning_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

final dioClientProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.dictionaryapi.dev/api/v2/entries/en',
      responseType: ResponseType.json,
    ),
  );
});

final dictionaryBoxProvider = Provider((ref) {
  return Hive.box<Word>('dictionary');
});

final bookmarksBoxProvider = Provider((ref) {
  return Hive.box<Word>('bookmarks');
});

final playerProvider = Provider.autoDispose((ref) {
  return AudioPlayer();
});
