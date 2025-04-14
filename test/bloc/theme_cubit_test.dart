import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multi_language_app/bloc/theme_cubit.dart';
import 'package:multi_language_app/services/theme_storage_interface.dart';

class MockThemeStorageService extends Mock implements ThemeStorageInterface {}

void main() {
  group('ThemeCubit', () {
    late MockThemeStorageService mockStorage;

    setUp(() {
      mockStorage = MockThemeStorageService();
      // Default mock behavior
      when(() => mockStorage.getSavedThemeMode()).thenReturn('light');
      when(() => mockStorage.saveThemeMode(any())).thenAnswer((_) async {});
    });

    test('initial state is light theme when storage returns light', () {
      when(() => mockStorage.getSavedThemeMode()).thenReturn('light');
      final themeCubit = ThemeCubit(storageService: mockStorage);
      expect(themeCubit.state, ThemeMode.light);
    });

    blocTest<ThemeCubit, ThemeMode>(
      'toggles from light to dark theme',
      build: () {
        when(() => mockStorage.getSavedThemeMode()).thenReturn('light');
        return ThemeCubit(storageService: mockStorage);
      },
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [ThemeMode.dark],
      verify: (_) {
        verify(() => mockStorage.saveThemeMode('dark')).called(1);
      },
    );
  });
}
