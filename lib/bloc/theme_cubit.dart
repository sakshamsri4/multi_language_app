import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_language_app/services/theme_storage_interface.dart';
import 'package:multi_language_app/services/theme_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeStorageInterface _storageService;

  ThemeCubit({ThemeStorageInterface? storageService})
      : _storageService = storageService ?? ThemeStorageService(),
        super(_getInitialTheme(storageService ?? ThemeStorageService()));

  // Get the initial theme from the stored value.
  static ThemeMode _getInitialTheme(ThemeStorageInterface storageService) {
    final savedTheme = storageService.getSavedThemeMode();
    return savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  // Toggle between light and dark themes and persist the selection.
  void toggleTheme() {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    _storageService.saveThemeMode(
      newTheme == ThemeMode.light ? 'light' : 'dark',
    );
  }
}
