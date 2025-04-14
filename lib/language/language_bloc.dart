import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:multi_language_app/services/language_storage_service.dart';

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
  LanguageBloc({LanguageStorageService? storageService})
      : _storageService = storageService ?? LanguageStorageService(),
        super(LanguageState(const Locale('en'))) {
    on<LanguageChanged>(_onLanguageChanged);
    _initLanguage();
  }
  final LanguageStorageService _storageService;

  Future<void> _initLanguage() async {
    final savedLocale = _storageService.getSavedLocale();
    if (savedLocale != null) {
      add(LanguageChanged(savedLocale));
    }
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageState(event.locale));
    await _storageService.saveLocale(event.locale);
  }
}
