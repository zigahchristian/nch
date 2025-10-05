import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/settings_sheet.dart';

// Mock HymnalModel
class MockHymnalModel extends Mock implements HymnalModel {}

void main() {
  late MockHymnalModel mockModel;

  setUp(() {
    mockModel = MockHymnalModel();
  });

  // Helper function to pump widget with provider
  Future<void> pumpSettingsSheet(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<HymnalModel>.value(
        value: mockModel,
        child: const MaterialApp(home: Scaffold(body: SettingsSheet())),
      ),
    );
  }

  group('SettingsSheet Render Test', () {
    testWidgets('should render SettingsSheet without crashing', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpSettingsSheet(tester);

      // Assert
      expect(find.byType(SettingsSheet), findsOneWidget);
    });

    testWidgets('should display text size label', (WidgetTester tester) async {
      // Arrange
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpSettingsSheet(tester);

      // Assert
      expect(find.text('Text size'), findsOneWidget);
    });

    testWidgets('should display slider for text size', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpSettingsSheet(tester);

      // Assert
      expect(find.byType(Slider), findsOneWidget);
    });
  });
}
