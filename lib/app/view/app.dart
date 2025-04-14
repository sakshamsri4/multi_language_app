import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_language_app/bloc/theme_cubit.dart';
import 'package:multi_language_app/core/app_theme.dart';
import 'package:multi_language_app/l10n/l10n.dart';
import 'package:multi_language_app/language/language_bloc.dart';
import 'package:multi_language_app/screens/first_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: languageState.locale,
                home: FlutterSplashScreen(
                  duration: const Duration(milliseconds: 5000),
                  nextScreen: const FirstScreen(),
                  backgroundColor: themeState == ThemeMode.dark
                      ? Colors.black
                      : Colors.white,
                  splashScreenBody: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/app_logo.png',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Multi Language App',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
