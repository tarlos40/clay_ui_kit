import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox('clay_ui_kit');
  }

  Future<Box> openBox(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    }
    return await Hive.openBox(name);
  }

  Box box(String name) => Hive.box(name);

  Future<void> put(String boxName, String key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  T get<T>(String boxName, String key, {T? defaultValue}) {
    final box = Hive.box(boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  Future<void> remove(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  Future<void> addToList<T>(String boxName, T value) async {
    final box = await openBox(boxName);
    await box.add(value);
  }

  List<T> getAll<T>(String boxName) {
    final box = Hive.box(boxName);
    return box.values.cast<T>().toList();
  }

  ValueListenable<Box> listen(String boxName) {
    return Hive.box(boxName).listenable();
  }

  bool exists(String boxName, String key) {
    return Hive.box(boxName).containsKey(key);
  }
}
