import 'dart:io';

import 'package:path/path.dart' as p;

/// Shared helpers for architecture tests. Paths are project-relative with
/// forward slashes, e.g. `lib/features/quran/domain/ayah.dart`.
class SourceFile {
  SourceFile(this.path, this.source);

  final String path;
  final String source;

  /// Resolved project-relative import targets (`lib/...`, `test/...`) and
  /// package imports for non-project packages (`package:dio/...`).
  List<String> get imports => parseImports(path, source);
}

final _importPattern = RegExp(
  r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

/// Returns every `lib/` Dart file in the project, excluding generated code.
List<SourceFile> loadLibFiles({String root = 'lib'}) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !_isGenerated(f.path))
      .map((f) {
        final rel = p.posix.joinAll(p.split(p.relative(f.path)));
        return SourceFile(rel, f.readAsStringSync());
      })
      .toList();
}

bool _isGenerated(String path) =>
    path.endsWith('.g.dart') ||
    path.endsWith('.freezed.dart') ||
    path.endsWith('.drift.dart') ||
    path.contains('/gen/');

/// Parses import/export directives of [filePath] (project-relative) and
/// normalises them. `package:quran_app/x` becomes `lib/x`; relative imports
/// are resolved against the importing file.
List<String> parseImports(String filePath, String source) {
  final result = <String>[];
  for (final m in _importPattern.allMatches(source)) {
    final uri = m.group(1)!;
    if (uri.startsWith('dart:')) continue;
    if (uri.startsWith('package:quran_app/')) {
      result.add('lib/${uri.substring('package:quran_app/'.length)}');
    } else if (uri.startsWith('package:')) {
      result.add(uri);
    } else {
      final resolved = p.posix.normalize(
        p.posix.join(p.posix.dirname(filePath), uri),
      );
      result.add(resolved);
    }
  }
  return result;
}

/// Matches a feature path and captures feature name and layer.
/// Example: `lib/features/quran/data/x.dart` -> feature `quran`, layer `data`.
final _featurePattern = RegExp(r'^lib/features/([^/]+)/([^/]+)/');

({String feature, String layer})? featureOf(String path) {
  final m = _featurePattern.firstMatch(path);
  if (m == null) return null;
  return (feature: m.group(1)!, layer: m.group(2)!);
}

/// Returns one message per violated rule. Empty list means clean.
List<String> checkLayerImports(SourceFile file) {
  final violations = <String>[];
  final self = featureOf(file.path);
  for (final target in file.imports) {
    // Third-party package rules.
    if (self != null && self.layer == 'domain') {
      for (final forbidden in _domainForbiddenPackages) {
        if (target == 'package:$forbidden' ||
            target.startsWith('package:$forbidden/')) {
          violations.add('domain imports $target');
        }
      }
    }

    final other = featureOf(target);
    if (other == null) continue;

    if (self != null && other.feature != self.feature) {
      // Cross-feature: only the other feature's domain layer is visible.
      if (other.layer != 'domain') {
        violations.add(
          '${self.feature} imports ${other.feature}/${other.layer} (only domain allowed)',
        );
      }
      continue;
    }

    if (self == null) continue;
    switch (self.layer) {
      case 'domain':
        if (other.layer != 'domain') {
          violations.add('domain imports ${other.layer}');
        }
      case 'presentation':
        if (other.layer == 'data' || other.layer == 'di') {
          violations.add('presentation imports ${other.layer}');
        }
      case 'data':
        if (other.layer == 'presentation' || other.layer == 'di') {
          violations.add('data imports ${other.layer}');
        }
    }
  }
  return violations;
}

const _domainForbiddenPackages = [
  'flutter',
  'flutter_riverpod',
  'riverpod',
  'dio',
  'drift',
  'go_router',
  'shared_preferences',
  'sqlite3',
];
