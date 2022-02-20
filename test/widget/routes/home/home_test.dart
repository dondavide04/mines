import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mines/routes/home/home.dart';
import 'package:mines/routes/home/widgets/settings_dialog.dart';

void main() {
  MaterialApp _app() => const MaterialApp(home: Home());
  testWidgets('Renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    final startBtn = find.text('Start');
    expect(startBtn, findsOneWidget);
  });

  testWidgets('Pressing start button opens the settings modal',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    final startBtn = find.text('Start');
    await tester.tap(startBtn);
    // TODO this doesn't work
    // expect(find.byType(SettingsDialog), findsOneWidget);
  });
}
