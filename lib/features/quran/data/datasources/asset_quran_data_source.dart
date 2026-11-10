import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/quran_language.dart';
import '../dto/quran_dtos.dart';

/// Reads the Quran JSON bundled under `assets/data/quran/`.
class AssetQuranDataSource {
  const AssetQuranDataSource(this._bundle);

  static const String root = 'assets/data/quran';

  final AssetBundle _bundle;

  Future<QuranMetaDto> readMeta() async {
    final json = await _readJson('$root/meta.json');
    return QuranMetaDto.fromJson(json);
  }

  Future<ArabicSurahDto> readArabic(int surah) async {
    final json = await _readJson('$root/arabic/${_name(surah)}.json');
    return ArabicSurahDto.fromJson(json);
  }

  Future<TranslationSurahDto> readTranslation({
    required QuranLanguage language,
    required int surah,
  }) async {
    final json = await _readJson('$root/${language.name}/${_name(surah)}.json');
    return TranslationSurahDto.fromJson(json);
  }

  static String _name(int surah) => surah.toString().padLeft(3, '0');

  Future<Map<String, dynamic>> _readJson(String path) async {
    try {
      final raw = await _bundle.loadString(path);
      return jsonDecode(raw) as Map<String, dynamic>;
    } on FlutterError catch (e) {
      throw AppException(StorageFailure('Missing asset $path: $e'));
    } on FormatException catch (e) {
      throw AppException(StorageFailure('Invalid JSON in $path: $e'));
    }
  }
}
