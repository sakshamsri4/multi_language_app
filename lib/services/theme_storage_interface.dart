abstract class ThemeStorageInterface {
  Future<void> init();
  Future<void> saveThemeMode(String themeMode);
  String getSavedThemeMode();
}
