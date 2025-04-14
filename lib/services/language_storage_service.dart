import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:multi_language_app/services/language_storage_interface.dart';

class LanguageStorageService implements LanguageStorageInterface {
  static const String _boxName = 'language_preferences';
  static const String _localeKey = 'locale';

  Box<String>? _box;

  @override
  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<String>(_boxName);
    } else {
      _box = Hive.box<String>(_boxName);
    }
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _box?.put(_localeKey, locale.languageCode);
  }

  @override
  Locale? getSavedLocale() {
    final savedLocaleCode = _box?.get(_localeKey);
    if (savedLocaleCode != null) {
      return Locale(savedLocaleCode);
    }
    return null;
  }
}
