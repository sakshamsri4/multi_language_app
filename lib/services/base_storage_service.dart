import 'package:hive/hive.dart';

abstract class BaseStorageService<T> {
  BaseStorageService(this.boxName);
  final String boxName;
  Box<T>? _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<T>(boxName);
    } else {
      _box = Hive.box<T>(boxName);
    }
  }

  Box<T>? get box => _box;

  Future<void> put(String key, T value) async {
    await _box?.put(key, value);
  }

  T? get(String key, {T? defaultValue}) {
    return _box?.get(key, defaultValue: defaultValue);
  }
}
