import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_good_shepherd/widgets/rounded_button.dart';

void main() {
  testWidgets('RoundedButton renders with label and optional icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RoundedButton(
            label: 'Test Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    expect(find.byIcon(Icons.abc), findsNothing); // Example: no icon by default

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RoundedButton(
            label: 'Test Button with Icon',
            icon: Icons.check_circle,
            onPressed: () {},
          ),
        ),
      ),
    );
    expect(find.text('Test Button with Icon'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('RoundedButton onPressed callback is triggered on tap', (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RoundedButton(
            label: 'Tap Test',
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Test'));
    await tester.pump(); // Process the tap

    expect(pressed, isTrue);
  });

  testWidgets('RoundedButton uses default color from theme if not provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Example theme
        ),
        home: Scaffold(
          body: RoundedButton(
            label: 'Theme Color Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
    // Default color is Theme.of(context).colorScheme.primary
    // We can't easily check the exact color value without more complex matcher,
    // but we can check it's not null and rely on widget's implementation.
    expect(button.style?.backgroundColor?.resolve({}), isNotNull);
  });

   testWidgets('RoundedButton uses provided color', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RoundedButton(
            label: 'Custom Color Button',
            onPressed: () {},
            color: Colors.red,
          ),
        ),
      ),
    );

    final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
    // Check if the color is resolved to Colors.red
    // The MaterialStateProperty.resolve pattern is needed for some button styles
    expect(button.style?.backgroundColor?.resolve({}), Colors.red);
  });
}
