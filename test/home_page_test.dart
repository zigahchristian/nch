import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/home_page.dart';

// Mock HymnalModel
class MockHymnalModel extends Mock implements HymnalModel {}

void main() {
  late MockHymnalModel mockModel;

  setUp(() {
    mockModel = MockHymnalModel();
  });

  // Helper function to pump widget with provider
  Future<void> pumpHomePage(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<HymnalModel>.value(
        value: mockModel,
        child: const MaterialApp(home: HomePage()),
      ),
    );
  }

  group('HomePage Render Test', () {
    testWidgets('should render HomePage without crashing', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.showFavoritesOnly).thenReturn(false);
      when(() => mockModel.filtered).thenReturn([]);

      // Act
      await pumpHomePage(tester);

      // Assert
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('should display app bar with title', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.showFavoritesOnly).thenReturn(false);
      when(() => mockModel.filtered).thenReturn([]);

      // Act
      await pumpHomePage(tester);

      // Assert
      expect(find.text('The New Catholic Hymnal'), findsOneWidget);
    });

    testWidgets('should display action icons in app bar', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.showFavoritesOnly).thenReturn(false);
      when(() => mockModel.filtered).thenReturn([]);

      // Act
      await pumpHomePage(tester);

      // Assert
      expect(find.byIcon(Icons.contact_page_sharp), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('should display empty state message', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.showFavoritesOnly).thenReturn(false);
      when(() => mockModel.filtered).thenReturn([]);

      // Act
      await pumpHomePage(tester);

      // Assert
      expect(find.text('No hymns found'), findsOneWidget);
    });

    testWidgets('should have correct widget structure', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.showFavoritesOnly).thenReturn(false);
      when(() => mockModel.filtered).thenReturn([]);

      // Act
      await pumpHomePage(tester);

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);
    });
  });
}
