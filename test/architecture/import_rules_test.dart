import 'package:flutter_test/flutter_test.dart';

import 'scan.dart';

void main() {
  group('layer import rules', () {
    test('domain, presentation, data and cross-feature rules hold', () {
      final files = loadLibFiles();
      final failures = <String>[];
      for (final f in files) {
        for (final v in checkLayerImports(f)) {
          failures.add('${f.path}: $v');
        }
      }
      expect(failures, isEmpty, reason: failures.join('\n'));
    });

    test('rule engine flags known violations', () {
      final domainFlutter = SourceFile(
        'lib/features/quran/domain/ayah.dart',
        "import 'package:flutter/material.dart';\n",
      );
      expect(checkLayerImports(domainFlutter), isNotEmpty);

      final presentationData = SourceFile(
        'lib/features/quran/presentation/screen.dart',
        "import '../data/quran_repository_impl.dart';\n",
      );
      expect(checkLayerImports(presentationData), isNotEmpty);

      final crossFeatureData = SourceFile(
        'lib/features/home/presentation/home.dart',
        "import 'package:quran_app/features/quran/data/x.dart';\n",
      );
      expect(checkLayerImports(crossFeatureData), isNotEmpty);

      final crossFeatureDomain = SourceFile(
        'lib/features/home/presentation/home.dart',
        "import 'package:quran_app/features/quran/domain/ayah.dart';\n",
      );
      expect(checkLayerImports(crossFeatureDomain), isEmpty);
    });

    test('domain never imports flutter, dio, drift or riverpod', () {
      final files = loadLibFiles().where(
        (f) => featureOf(f.path)?.layer == 'domain',
      );
      for (final f in files) {
        expect(checkLayerImports(f), isEmpty, reason: f.path);
      }
    });
  });
}
