import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:nch/models/hymn.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/hymnal_detail_page.dart';

// Mock HymnalModel
class MockHymnalModel extends Mock implements HymnalModel {}

void main() {
  late MockHymnalModel mockModel;
  late Hymn testHymn;

  setUp(() {
    mockModel = MockHymnalModel();
    testHymn = Hymn(
      number: 1,
      title: 'Test Hymn',
      firstLine: 'First line of hymn',
      lyrics: 'Hymn lyrics content',
      author: '',
      composer: '',
    );
  });

  // Helper function to pump widget with provider
  Future<void> pumpHymnDetailPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<HymnalModel>.value(
        value: mockModel,
        child: MaterialApp(home: HymnDetailPage(hymn: testHymn)),
      ),
    );
  }

  group('HymnDetailPage Render Test', () {
    testWidgets('should render HymnDetailPage without crashing', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.favoriteSet).thenReturn({});
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpHymnDetailPage(tester);

      // Assert
      expect(find.byType(HymnDetailPage), findsOneWidget);
    });

    testWidgets('should display hymn number in app bar', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.favoriteSet).thenReturn({});
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpHymnDetailPage(tester);

      // Assert
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should display hymn first line and lyrics', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.favoriteSet).thenReturn({});
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpHymnDetailPage(tester);

      // Assert
      expect(find.text('First line of hymn'), findsOneWidget);
      expect(find.text('Hymn lyrics content'), findsOneWidget);
    });

    testWidgets('should display action buttons in app bar', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockModel.favoriteSet).thenReturn({});
      when(() => mockModel.textScale).thenReturn(1.0);

      // Act
      await pumpHymnDetailPage(tester);

      // Assert
      expect(find.byIcon(Icons.share), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });
}
