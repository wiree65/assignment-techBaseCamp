import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_app/main.dart' as app;
import 'package:my_app/screens/landing_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
    () {
      testWidgets(
        'verify login screen with correct username and password',
        (tester) async {
          app.main(true);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byType(TextField).at(0), 'katak1@gmail.com');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '12345678');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(LandingScreen), findsOneWidget);
        },
      );

      testWidgets(
        'verify login screen with incorrect username and password',
        (tester) async {
          app.main(true);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byType(TextField).at(0), 'katak1@gmail.com');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(
              find.text(
                  'The password is invalid or the user does not have a password.'),
              findsOneWidget);
        },
      );
    },
  );
}
