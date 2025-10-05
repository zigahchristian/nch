import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nch/main.dart';
import 'package:provider/provider.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/loading_screen.dart';

// Mock HymnalModel for testing
class MockHymnalModel extends Mock implements HymnalModel {}

void main() {
  group('HymnalApp', () {
    testWidgets('should build without throwing', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const HymnalApp());

      // Verify that the app builds successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should provide HymnalModel to the widget tree', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const HymnalApp());

      // Verify that ChangeNotifierProvider is in the tree
      expect(find.byType(ChangeNotifierProvider<HymnalModel>), findsOneWidget);
    });

    testWidgets('should create MaterialApp with correct configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const HymnalApp());

      // Find the MaterialApp
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Verify MaterialApp properties
      expect(materialApp.debugShowCheckedModeBanner, false);
      expect(materialApp.title, 'Catholic Hymnal');
      expect(materialApp.home, isA<LoadingScreen>());
    });

    testWidgets('should display LoadingScreen as initial route', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const HymnalApp());

      // Verify that LoadingScreen is displayed
      expect(find.byType(LoadingScreen), findsOneWidget);
    });

    testWidgets('should create HymnalModel instance', (
      WidgetTester tester,
    ) async {
      HymnalModel? capturedModel;

      await tester.pumpWidget(
        ChangeNotifierProvider<HymnalModel>(
          create: (context) {
            capturedModel = HymnalModel();
            return capturedModel!;
          },
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                // Access the provider to ensure it's created
                final model = Provider.of<HymnalModel>(context);
                return Container();
              },
            ),
          ),
        ),
      );

      // Verify that HymnalModel instance was created
      expect(capturedModel, isNotNull);
      expect(capturedModel, isA<HymnalModel>());
    });

    testWidgets('should handle widget rebuilds correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const HymnalApp());

      // Verify initial state
      expect(find.byType(LoadingScreen), findsOneWidget);

      // Rebuild with same widget
      await tester.pumpWidget(const HymnalApp());

      // Verify state remains consistent
      expect(find.byType(LoadingScreen), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('HymnalApp Edge Cases', () {
    testWidgets('should handle different screen sizes', (
      WidgetTester tester,
    ) async {
      // Test with a small screen size
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const HymnalApp());
      expect(find.byType(MaterialApp), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should handle platform brightness changes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const HymnalApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Verify theme exists and has basic properties
      expect(materialApp.theme, isNotNull);
      expect(materialApp.theme!.useMaterial3, true);
    });
  });
}
