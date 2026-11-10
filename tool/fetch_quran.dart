// Downloads the Quran text and translations from QuranEnc into assets/data/quran/.
//
// Run only when the source data changes:
//   dart run tool/fetch_quran.dart
//
// Output layout:
//   assets/data/quran/meta.json           surah list, Juz marks, translation metadata
//   assets/data/quran/arabic/NNN.json     Arabic text of surah NNN (from QuranEnc arabic_text)
//   assets/data/quran/<lang>/NNN.json     translation of surah NNN for <lang>
//
// The Arabic text comes only from QuranEnc. Every language response must carry
// the same arabic_text, otherwise the script fails.
import 'dart:convert';
import 'dart:io';

const _outDir = 'assets/data/quran';
const _apiBase = 'https://quranenc.com/api/v1';
const _metaUrl = 'https://api.alquran.cloud/v1/meta';

const _translations = <String, String>{
  'en': 'english_saheeh',
  'id': 'indonesian_affairs',
  'ur': 'urdu_junagarhi',
  'tr': 'turkish_rwwad',
};

Future<void> main() async {
  final client = HttpClient();
  try {
    await _run(client);
  } finally {
    client.close(force: true);
  }
}

Future<void> _run(HttpClient client) async {
  final translationInfo = <String, Map<String, String>>{};
  for (final entry in _translations.entries) {
    final lang = entry.key;
    final key = entry.value;
    final list = await _getJson(client, '$_apiBase/translations/list/$lang');
    final hit = (list['translations'] as List).cast<Map<String, dynamic>>().firstWhere(
          (t) => t['key'] == key,
          orElse: () => throw StateError('Translation $key not found in list/$lang'),
        );
    translationInfo[lang] = {
      'key': key,
      'title': hit['title'] as String,
      'version': hit['version'] as String,
    };
  }

  final alquran = (await _getJson(client, _metaUrl))['data'] as Map<String, dynamic>;
  final surahRefs = (alquran['surahs']['references'] as List).cast<Map<String, dynamic>>();
  final juzRefs = (alquran['juzs']['references'] as List).cast<Map<String, dynamic>>();

  final meta = {
    'translations': translationInfo,
    'surahs': [
      for (final s in surahRefs)
        {
          'n': s['number'],
          'name': s['englishName'],
          'meaning': s['englishNameTranslation'],
          'ar': s['name'],
          'ayahs': s['numberOfAyahs'],
          'place': s['revelationType'],
        },
    ],
    'juzs': [for (final j in juzRefs) {'surah': j['surah'], 'ayah': j['ayah']}],
  };

  final dir = Directory(_outDir)..createSync(recursive: true);
  Directory('${dir.path}/arabic').createSync(recursive: true);
  for (final lang in _translations.keys) {
    Directory('${dir.path}/$lang').createSync(recursive: true);
  }
  _writeJson('${dir.path}/meta.json', meta);

  for (var n = 1; n <= 114; n++) {
    final arabicByLang = <String, List<String>>{};
    final translated = <String, List<Map<String, String?>>>{};
    for (final entry in _translations.entries) {
      final result = (await _getJson(client, '$_apiBase/translation/sura/${entry.value}/$n'))['result']
          as List;
      final rows = result.cast<Map<String, dynamic>>();
      arabicByLang[entry.key] = [for (final r in rows) r['arabic_text'] as String];
      translated[entry.key] = [
        for (final r in rows)
          {'t': r['translation'] as String, 'f': _nullIfEmpty(r['footnotes'] as String?)},
      ];
    }

    final arabic = arabicByLang.values.first;
    for (final other in arabicByLang.entries) {
      if (!_sameList(arabic, other.value)) {
        throw StateError('arabic_text differs between languages in surah $n (${other.key})');
      }
    }

    final name = n.toString().padLeft(3, '0');
    _writeJson('${dir.path}/arabic/$name.json', {'surah': n, 'ayahs': arabic});
    for (final entry in translated.entries) {
      _writeJson('${dir.path}/${entry.key}/$name.json', {'surah': n, 'ayahs': entry.value});
    }
    stdout.writeln('surah $n: ${arabic.length} ayahs');
  }
  stdout.writeln('Done. Output in $_outDir');
}

String? _nullIfEmpty(String? value) => (value == null || value.isEmpty) ? null : value;

bool _sameList(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

Future<Map<String, dynamic>> _getJson(HttpClient client, String url) async {
  Object? lastError;
  for (var attempt = 0; attempt < 4; attempt++) {
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != 200) {
        throw HttpException('HTTP ${response.statusCode} for $url');
      }
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (e) {
      lastError = e;
      await Future<void>.delayed(Duration(milliseconds: 800 * (attempt + 1)));
    }
  }
  throw StateError('Failed after retries: $url ($lastError)');
}

void _writeJson(String path, Object data) {
  File(path).writeAsStringSync(jsonEncode(data));
}
