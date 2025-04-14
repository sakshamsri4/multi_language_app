import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// Events
abstract class LanguageEvent {}

class LanguageChanged extends LanguageEvent {
  LanguageChanged(this.locale);
  final Locale locale;
}

// States
class LanguageState {
  LanguageState(this.locale);
  final Locale locale;
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(const Locale('en'))) {
    on<LanguageChanged>(_onLanguageChanged);
    _initHive();
  }
  static const String _boxName = 'language_preferences';
  static const String _localeKey = 'locale';

  Future<void> _initHive() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);

      final box = await Hive.openBox<dynamic>(_boxName);
      final savedLocale = box.get(_localeKey);

      if (savedLocale != null && savedLocale is String) {
        add(LanguageChanged(Locale(savedLocale)));
      }
    } catch (e) {
      // Fallback to default locale if there's an error
    }
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageState(event.locale));

    try {
      final box = await Hive.openBox<dynamic>(_boxName);
      await box.put(_localeKey, event.locale.languageCode);
    } catch (e) {
      // Handle error saving preference
    }
  }
}
