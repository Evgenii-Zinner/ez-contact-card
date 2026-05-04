import 'package:ez_contact_card/ez_contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EzContactCard', () {
    const String testName = 'John Doe';
    const String testSubtitle = 'Software Engineer';
    const Widget testAvatar = CircleAvatar(child: Text('JD'));
    const Widget testTail = Icon(Icons.arrow_forward_ios);

    testWidgets('renders basic contact card', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
            ),
          ),
        ),
      );

      expect(find.text(testName), findsOneWidget);
      expect(find.byWidget(testAvatar), findsOneWidget);
      expect(find.text(testSubtitle), findsNothing);
    });

    testWidgets('renders subtitle and tail when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              subtitle: testSubtitle,
              avatar: testAvatar,
              tail: testTail,
            ),
          ),
        ),
      );

      expect(find.text(testName), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);
      expect(find.byWidget(testTail), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(EzContactCard));
      expect(tapped, isTrue);
    });

    testWidgets(
        'applies visual properties (border, borderRadius, color, elevation)',
        (WidgetTester tester) async {
      const Color bgColor = Colors.blue;
      final Border border = Border.all(color: Colors.red, width: 2.0);
      final BorderRadius borderRadius = BorderRadius.circular(10.0);
      const double elevation = 5.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              backgroundColor: bgColor,
              border: border,
              borderRadius: borderRadius,
              elevation: elevation,
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, bgColor);
      expect(decoration.border, border);
      expect(decoration.borderRadius, borderRadius);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.first.blurRadius, elevation);
    });

    testWidgets('prefers decoration over shorthand visual properties',
        (WidgetTester tester) async {
      const Color bgColor = Colors.blue;
      const Color decorationColor = Colors.green;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              backgroundColor: bgColor,
              decoration: BoxDecoration(color: decorationColor),
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, decorationColor);
      expect(decoration.color, isNot(bgColor));
    });

    testWidgets('respects nameMaxLines and subtitleMaxLines',
        (WidgetTester tester) async {
      const int nameMaxLines = 2;
      const int subtitleMaxLines = 3;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              subtitle: testSubtitle,
              avatar: testAvatar,
              nameMaxLines: nameMaxLines,
              subtitleMaxLines: subtitleMaxLines,
            ),
          ),
        ),
      );

      final nameText = tester.widget<Text>(find.text(testName));
      final subtitleText = tester.widget<Text>(find.text(testSubtitle));

      expect(nameText.maxLines, nameMaxLines);
      expect(subtitleText.maxLines, subtitleMaxLines);
    });

    testWidgets('layout respects gap', (WidgetTester tester) async {
      const double customGap = 20.0;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              tail: testTail,
              gap: customGap,
            ),
          ),
        ),
      );

      // We expect two SizedBoxes with width = customGap
      final sizedBoxes = find.byType(SizedBox);
      bool foundGap = false;
      for (var element in tester.widgetList<SizedBox>(sizedBoxes)) {
        if (element.width == customGap) {
          foundGap = true;
        }
      }
      expect(foundGap, isTrue);
    });
  });
}
