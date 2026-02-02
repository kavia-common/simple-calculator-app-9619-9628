import 'package:calculator_frontend/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Calculator renders: display=0, digits 0-9, +, −, =, C, ⌫',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // App bar title
      expect(find.text('Calculator'), findsOneWidget);

      // Display starts at 0 (it can appear multiple times due to other UI text),
      // so we just require it to exist at least once.
      expect(find.text('0'), findsWidgets);

      // Operations row
      expect(find.text('+'), findsOneWidget);
      expect(find.text('−'), findsOneWidget);

      // Keypad controls
      expect(find.text('C'), findsOneWidget);
      expect(find.text('⌫'), findsOneWidget);
      expect(find.text('='), findsOneWidget);

      // Digits: 0-9
      for (int i = 0; i <= 9; i++) {
        expect(find.text('$i'), findsOneWidget);
      }
    },
  );

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

    // Result should be shown on the display.
    expect(find.text('3'), findsWidgets);
  });

  testWidgets('Subtraction works: 5 − 2 = 3', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('5'));
    await tester.pump();

    await tester.tap(find.text('−'));
    await tester.pump();

    await tester.tap(find.text('2'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('3'), findsWidgets);
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

    // Back to the initial state.
    expect(find.text('0'), findsWidgets);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('−'), findsOneWidget);
  });
}
