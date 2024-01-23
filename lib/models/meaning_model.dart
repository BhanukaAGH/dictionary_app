import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'meaning_model.g.dart';

@immutable
@HiveType(typeId: 0)
class Word {
  @HiveField(0)
  final String word;
  @HiveField(1)
  final String phonetic;
  @HiveField(2)
  final List<Phonetic> phonetics;
  @HiveField(3)
  final List<Meaning> meanings;

  const Word({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });

  factory Word.fromJson(Map<String, dynamic> map) {
    return Word(
      word: map['word'] ?? '',
      phonetic: map['phonetic'] ?? '',
      phonetics: List<Phonetic>.from(
          map['phonetics']?.map((x) => Phonetic.fromJson(x))),
      meanings:
          List<Meaning>.from(map['meanings']?.map((x) => Meaning.fromJson(x))),
    );
  }
}

@HiveType(typeId: 1)
class Meaning {
  @HiveField(0)
  final String partOfSpeech;
  @HiveField(1)
  final List<Definition> definitions;
  @HiveField(2)
  final List<dynamic> synonyms;
  @HiveField(3)
  final List<dynamic> antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> map) {
    return Meaning(
      partOfSpeech: map['partOfSpeech'] ?? '',
      definitions: List<Definition>.from(
          map['definitions']?.map((x) => Definition.fromJson(x))),
      synonyms: List<dynamic>.from(map['synonyms']),
      antonyms: List<dynamic>.from(map['antonyms']),
    );
  }
}

@HiveType(typeId: 2)
class Definition {
  @HiveField(0)
  final String definition;
  @HiveField(1)
  final List<dynamic> synonyms;
  @HiveField(2)
  final List<dynamic> antonyms;
  @HiveField(3)
  final String? example;

  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> map) {
    return Definition(
      definition: map['definition'] ?? '',
      synonyms: List<dynamic>.from(map['synonyms']),
      antonyms: List<dynamic>.from(map['antonyms']),
      example: map['example'],
    );
  }
}

@HiveType(typeId: 3)
class Phonetic {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final String audio;

  Phonetic({
    required this.text,
    required this.audio,
  });

  factory Phonetic.fromJson(Map<String, dynamic> map) {
    return Phonetic(
      text: map['text'] ?? '',
      audio: map['audio'] ?? '',
    );
  }
}
