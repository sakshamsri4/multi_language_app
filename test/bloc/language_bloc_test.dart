import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_language_app/language/language_bloc.dart';

void main() {
  group('LanguageBloc', () {
    test('initial state has default locale', () {
      final languageBloc = LanguageBloc();
      expect(languageBloc.state.locale, isNotNull);
    });

    blocTest<LanguageBloc, LanguageState>(
      'emits new locale when language is changed',
      build: LanguageBloc.new,
      act: (bloc) => bloc.add(LanguageChanged(const Locale('es'))),
      expect: () => [
        isA<LanguageState>()
            .having((state) => state.locale.languageCode, 'languageCode', 'es'),
      ],
    );
  });
}
