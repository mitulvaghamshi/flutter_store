import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_store/ajson_app/models/inventory.dart';
import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Object? json);

final _headers = {HttpHeaders.contentTypeHeader: ContentType.json.value};

@immutable
interface class Repo<T> {
  const Repo({required this.items});

  const Repo.empty() : items = const [];

  final Iterable<T> items;

  static Future<Repo<T>> asset<T>(String path, FromJson<T> fromJson) async {
    assert(path.isNotEmpty, '[$Repo/asset]: Invalid asset path, $path');
    final content = await rootBundle.loadString(path);
    if (jsonDecode(content) case Iterable<dynamic> items) {
      return Repo<T>(items: items.map(fromJson));
    }
    throw FormatException('[$Repo/asset]: Invalid JSON');
  }

  static Future<Repo<T>> query<T>(Uri uri, FromJson<T> fromJson) async {
    final res = await http.get(uri, headers: _headers);
    final content = jsonDecode(res.body);
    if (res.statusCode == HttpStatus.ok) {
      if (content case Iterable<dynamic> items) {
        return Repo<T>(items: items.map(fromJson));
      }
      throw FormatException('[$Repo/query]: Invalid JSON');
    }
    throw HttpException('[$Repo/query]: ${res.statusCode} ${res.reasonPhrase}');
  }

  static Future<bool> insert<T>(Uri uri, Pet pet) async {
    final res = await http.post(uri, headers: _headers, body: pet.toJson);
    return res.statusCode == HttpStatus.ok;
  }

  static Future<bool> update<T>(Uri uri, Pet pet) async {
    final res = await http.patch(uri, headers: _headers, body: pet.toJson);
    return res.statusCode == HttpStatus.ok;
  }

  static Future<bool> delete<T>(Uri uri) async {
    final res = await http.delete(uri, headers: _headers);
    return res.statusCode == HttpStatus.ok;
  }
}
