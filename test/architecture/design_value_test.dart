import 'package:flutter_test/flutter_test.dart';

import 'scan.dart';

/// Raw design values are only allowed inside the design system itself.
/// Everything else must reach tokens such as `AppColors` or `AppSpacing`.
final _rawColor = RegExp(r'Color\(\s*0x[0-9A-Fa-f]+\s*\)');
// A digit that starts a number, not one inside an identifier like `space16`.
final _rawEdgeInsets = RegExp(r'EdgeInsets(?:\.\w+)?\([^)]*(?<!\w)\d');

bool _isDesignSystemFile(String path) =>
    path.startsWith('lib/core/design_system/');

List<String> findRawDesignValues(SourceFile file) {
  final hits = <String>[];
  final lines = file.source.split('\n');
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.trimLeft().startsWith('//')) continue;
    if (_rawColor.hasMatch(line)) {
      hits.add('${file.path}:${i + 1} raw Color(0x..)');
    }
    if (_rawEdgeInsets.hasMatch(line)) {
      hits.add('${file.path}:${i + 1} raw EdgeInsets number');
    }
  }
  return hits;
}

void main() {
  test('rule engine detects raw colors and insets', () {
    final sample = SourceFile(
      'lib/x.dart',
      'final c = Color(0xFF15120D);\n'
          'final p = EdgeInsets.all(16);\n'
          'final ok = EdgeInsets.all(AppSpacing.space16);\n',
    );
    expect(findRawDesignValues(sample), hasLength(2));
  });

  test('no raw color or EdgeInsets number outside core/design_system', () {
    final failures = <String>[];
    for (final f in loadLibFiles()) {
      if (_isDesignSystemFile(f.path)) continue;
      failures.addAll(findRawDesignValues(f));
    }
    expect(failures, isEmpty, reason: failures.join('\n'));
  });
}
