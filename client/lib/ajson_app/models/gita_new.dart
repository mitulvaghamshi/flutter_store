import 'package:flutter/foundation.dart';
import 'package:flutter_store/ajson_app/api/repo.dart';

@immutable
mixin GitaNew {
  static Future<Repo<Snippet>> get queryEn async {
    return Repo.asset('assets/gita_snippets_en.json', Snippet.fromJson);
  }

  static Future<Repo<Snippet>> get queryHi async {
    return Repo.asset('assets/gita_snippets_en.json', Snippet.fromJson);
  }
}

@immutable
class Snippet {
  const Snippet({
    required this.id,
    required this.title,
    required this.chapter,
    required this.verses,
    required this.sanskrit,
    required this.transliteration,
    required this.verseTranslations,
    required this.commentary,
    required this.reflection,
    required this.shortReflection,
  });

  factory Snippet.fromJson(Object? json) {
    if (json case {
      'id': int id,
      'title': String title,
      'chapter': int chapter,
      'verses': String verses,
      'sanskrit': String sanskrit,
      'transliteration': String transliteration,
      'verseTranslations': List<dynamic> verseTranslations,
      'commentary': String commentary,
      'reflection': String reflection,
      'shortReflection': String shortReflection,
    }) {
      return Snippet(
        id: id,
        title: title,
        chapter: chapter,
        verses: verses,
        sanskrit: sanskrit,
        transliteration: transliteration,
        verseTranslations: Iterable.castFrom(verseTranslations),
        commentary: commentary,
        reflection: reflection,
        shortReflection: shortReflection,
      );
    }
    throw FormatException('[$Snippet]: Invalid JSON');
  }

  final int id;
  final String title;
  final int chapter;
  final String verses;
  final String sanskrit;
  final String transliteration;
  final Iterable<String> verseTranslations;
  final String commentary;
  final String reflection;
  final String shortReflection;
}
