import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nch/screens/contact_screen.dart'; // Update with your actual import path

void main() {
  group('ContactScreen Render Test', () {
    testWidgets('should render ContactScreen without crashing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ContactScreen()));

      expect(find.byType(ContactScreen), findsOneWidget);
    });

    testWidgets('should display main title and description', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ContactScreen()));

      expect(find.text('About The New Catholic Hymnal 2021'), findsOneWidget);
      expect(find.text('About Us'), findsOneWidget);
    });

    testWidgets('should display all contact information cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ContactScreen()));

      expect(find.text('Company'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
    });

    testWidgets('should display contact details', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ContactScreen()));

      expect(find.text('OLGABYTE'), findsOneWidget);
      expect(find.text('olgabyte256@gmail.com'), findsOneWidget);
      expect(find.text('+233 (0) 55 323 0095'), findsOneWidget);
      expect(find.text('Accra, Ghana'), findsOneWidget);
    });
  });
}
