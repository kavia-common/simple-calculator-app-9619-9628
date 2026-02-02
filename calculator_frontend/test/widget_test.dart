import 'package:flutter_test/flutter_test.dart';

import 'package:calculator_frontend/main.dart';

void main() {
  testWidgets('Calculator renders basic UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // App bar title
    expect(find.text('Calculator'), findsOneWidget);

    // Display starts at 0
    expect(find.text('0'), findsWidgets);

    // Operations row
    expect(find.text('+'), findsOneWidget);
    expect(find.text('−'), findsOneWidget);

    // Keypad basics
    expect(find.text('C'), findsOneWidget);
    expect(find.text('⌫'), findsOneWidget);
    expect(find.text('.'), findsOneWidget);
    expect(find.text('='), findsOneWidget);

    // Some digits
    expect(find.text('1'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
  });

  testWidgets('Addition works: 1 + 2 = 3', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('1'));
    await tester.pump();

    await tester.tap(find.text('+'));
    await tester.pump();

    await tester.tap(find.text('2'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('3'), findsWidgets);
  });

  testWidgets('Subtraction works: 9 − 4 = 5', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('9'));
    await tester.pump();

    await tester.tap(find.text('−'));
    await tester.pump();

    await tester.tap(find.text('4'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('5'), findsWidgets);
  });

  testWidgets('Backspace deletes last character', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.pump();

    await tester.tap(find.text('⌫'));
    await tester.pump();

    // 123 -> 12
    expect(find.text('12'), findsWidgets);
  });

  testWidgets('Clear resets state', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('7'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('8'));
    await tester.pump();

    await tester.tap(find.text('C'));
    await tester.pump();

    expect(find.text('0'), findsWidgets);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('−'), findsOneWidget);
  });
}
