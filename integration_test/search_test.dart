import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/controller/movieProvider.dart';
import 'package:my_app/screens/moive_detail_screen.dart';
import 'package:my_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('SearchScreen integration test', (WidgetTester tester) async {
    // Mock MovieProvider
    final movieProvider = MovieProvider();

    // Build the SearchScreen widget wrapped in a Provider widget
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MovieProvider>.value(value: movieProvider),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SearchScreen(),
          ),
        ),
      ),
    );

    expect(find.text('Search'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.enterText(find.byType(TextField), 'astra');
    expect(movieProvider.searchResults.length, 0);

    movieProvider.performSearch('astra');
    await tester.pumpAndSettle();

    // Verify the search results
    expect(movieProvider.isLoading, false);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListTile),
        findsNWidgets(movieProvider.searchResults.length));

    expect(find.text('No results found.'), findsNothing);

    // Tap on a movie in the search results
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailScreen), findsOneWidget);
  });
}
