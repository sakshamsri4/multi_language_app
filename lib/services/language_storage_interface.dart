import 'package:flutter/material.dart';

abstract class LanguageStorageInterface {
  Future<void> init();
  Future<void> saveLocale(Locale locale);
  Locale? getSavedLocale();
}
