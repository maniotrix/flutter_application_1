// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Home Screen Tests', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();

    Future.delayed(const Duration(milliseconds: 500));

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Nothing'), findsNothing);
  });
}
