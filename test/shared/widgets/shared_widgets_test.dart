import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/design_system/design_system.dart';
import 'package:quran_app/shared/widgets/shared_widgets.dart';

Widget _host(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? AppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testWidgets('AppButton fires onPressed and shows its label', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(AppButton(label: 'Start', onPressed: () => taps++)),
    );
    expect(find.text('Start'), findsOneWidget);
    await tester.tap(find.text('Start'));
    expect(taps, 1);
  });

  testWidgets('AppButton with no handler is disabled', (tester) async {
    await tester.pumpWidget(_host(const AppButton(label: 'Off')));
    final ink = tester.widget<InkWell>(find.byType(InkWell).first);
    expect(ink.onTap, isNull);
  });

  testWidgets('AppIconButton exposes its semantic label', (tester) async {
    await tester.pumpWidget(
      _host(
        AppIconButton(
          icon: Icons.close_rounded,
          semanticLabel: 'Close',
          onPressed: () {},
        ),
      ),
    );
    expect(find.byTooltip('Close'), findsOneWidget);
  });

  testWidgets('AppSwitch reports changes', (tester) async {
    var value = false;
    await tester.pumpWidget(
      _host(
        StatefulBuilder(
          builder: (context, setState) => AppSwitch(
            value: value,
            onChanged: (v) => setState(() => value = v),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(value, isTrue);
  });

  testWidgets('AppSegmented selects an option', (tester) async {
    var selected = 'small';
    await tester.pumpWidget(
      _host(
        StatefulBuilder(
          builder: (context, setState) => AppSegmented<String>(
            options: const [
              AppSegmentOption(value: 'small', label: 'Small'),
              AppSegmentOption(value: 'large', label: 'Large'),
            ],
            selected: selected,
            onChanged: (v) => setState(() => selected = v),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Large'));
    await tester.pump();
    expect(selected, 'large');
  });

  testWidgets('AppTabBar reports the tapped index', (tester) async {
    int? tapped;
    await tester.pumpWidget(
      _host(
        AppTabBar(
          items: const [
            AppTabItem(icon: Icons.home_rounded, label: 'Home'),
            AppTabItem(icon: Icons.menu_book_rounded, label: 'Quran'),
          ],
          currentIndex: 0,
          onTap: (i) => tapped = i,
        ),
      ),
    );
    await tester.tap(find.text('Quran'));
    expect(tapped, 1);
  });

  testWidgets('AppSection divides rows and shows an uppercase title', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const AppSection(
          title: 'Prayer times',
          children: [
            AppRow(title: 'Calculation'),
            AppRow(title: 'Asr'),
          ],
        ),
      ),
    );
    expect(find.text('PRAYER TIMES'), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('showAppToast shows the message with an action', (tester) async {
    var undone = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showAppToast(
                context,
                'Marked as prayed',
                actionLabel: 'Undo',
                onAction: () => undone = true,
              ),
              child: const Text('show'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('show'));
    await tester.pumpAndSettle();
    expect(find.text('Marked as prayed'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(undone, isTrue);
  });

  testWidgets('showAppConfirmDialog resolves to the chosen answer', (
    tester,
  ) async {
    bool? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await showAppConfirmDialog(
                  context: context,
                  title: 'Prayer prompts',
                  message: 'Pause prayer prompts?',
                  confirmLabel: 'Pause',
                  cancelLabel: 'Cancel',
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pause'));
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });

  testWidgets('AppNavBar and AppLargeHeader render their text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: const Scaffold(
          appBar: AppNavBar(title: 'Settings'),
          body: AppLargeHeader(title: 'Today', subtitle: 'Friday'),
        ),
      ),
    );
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
  });
}
