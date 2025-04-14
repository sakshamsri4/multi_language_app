import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:multi_language_app/services/language_storage_service.dart';
import 'package:multi_language_app/services/theme_storage_service.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> _initializeHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
}

Future<void> _initializeServices() async {
  // Initialize ThemeStorageService
  final themeService = ThemeStorageService();
  await themeService.init();

  // Initialize LanguageStorageService
  final languageService = LanguageStorageService();
  await languageService.init();
}

Future<void> _setupErrorHandling() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = const AppBlocObserver();
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Initialize Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Setup error handling
  await _setupErrorHandling();

  // Initialize Hive
  await _initializeHive();

  // Initialize services
  await _initializeServices();

  // Run the app
  runApp(await builder());
}
