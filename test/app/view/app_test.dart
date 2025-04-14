import 'package:flutter_test/flutter_test.dart';
import 'package:multi_language_app/app/app.dart';
import 'package:multi_language_app/app/view/app.dart';
import 'package:multi_language_app/screens/first_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders App', (tester) async {
      await tester.pumpWidget(const App());

      // Initial pump to show splash screen
      await tester.pump();

      // Fast forward 2000ms (matching the splash screen duration in app.dart)
      await tester.pump(const Duration(milliseconds: 2000));

      // Additional pump to trigger navigation after splash screen
      await tester.pumpAndSettle();

      // Now verify the app rendered correctly
      expect(find.byType(FirstScreen), findsOneWidget);
    });
  });
}
