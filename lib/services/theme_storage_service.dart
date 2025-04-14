import 'package:hive/hive.dart';
import 'package:multi_language_app/services/theme_storage_interface.dart';

class ThemeStorageService implements ThemeStorageInterface {
  static const String boxName = 'themeBox';
  static const String keyThemeMode = 'themeMode';

  static Box<String>? _box;

  @override
  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<String>(boxName);
    } else {
      _box = Hive.box<String>(boxName);
    }
  }

  @override
  Future<void> saveThemeMode(String themeMode) async {
    await _box?.put(keyThemeMode, themeMode);
  }

  @override
  String getSavedThemeMode() {
    return _box?.get(keyThemeMode, defaultValue: 'light') ?? 'light';
  }
}
