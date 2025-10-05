import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/loading_screen.dart';

// Mock HymnalModel
class MockHymnalModel extends Mock implements HymnalModel {}

void main() {
  late MockHymnalModel mockModel;

  setUp(() {
    mockModel = MockHymnalModel();
  });

  // Helper function to pump widget with provider
  Future<void> pumpLoadingScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<HymnalModel>.value(
        value: mockModel,
        child: const MaterialApp(home: LoadingScreen()),
      ),
    );
  }

  group('LoadingScreen Render Test', () {
    testWidgets('should render LoadingScreen without crashing', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.loadFromAssets(any())).thenAnswer((_) async {});

      // Act
      await pumpLoadingScreen(tester);

      // Assert
      expect(find.byType(LoadingScreen), findsOneWidget);
    });

    testWidgets('should display circular progress indicator', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.loadFromAssets(any())).thenAnswer((_) async {});

      // Act
      await pumpLoadingScreen(tester);

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show loading in center of screen', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.loadFromAssets(any())).thenAnswer((_) async {});

      // Act
      await pumpLoadingScreen(tester);

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
    });
  });
}
