import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_language_app/bloc/theme_cubit.dart';
import 'package:multi_language_app/l10n/l10n.dart';
import 'package:multi_language_app/language/language_bloc.dart';
import 'package:multi_language_app/screens/first_screen.dart';

void main() {
  testWidgets('FirstScreen displays correctly', (tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LanguageBloc()),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: FirstScreen(),
        ),
      ),
    );

    // First pump to start building the widget tree
    await tester.pump();

    // Pump with a duration to allow for any animations/timers
    await tester.pump(const Duration(milliseconds: 100));

    // Final pump to ensure everything is settled
    await tester.pumpAndSettle();

    // Verify key elements are present
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
  });
}
