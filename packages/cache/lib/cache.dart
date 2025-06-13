library;

import 'package:shared_preferences/shared_preferences.dart';

/// {@template cache_client}
/// A persistent key-value cache client using SharedPreferences.
/// {@endtemplate}
class CacheClient {
  /// Default constructor – no instance arguments are needed.
  CacheClient();

  // A static variable to hold the SharedPreferences instance.
  static late final SharedPreferences _prefs;

  /// Initializes the cache.
  /// Must be called (and awaited) before any CacheClient is created.
  static Future<void> initializeCache() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Writes the provided [key], [value] pair to the cache.
  void write<T>({required String key, required T? value}) {
    if (value == null) {
      _prefs.remove(key);
    } else if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported type for SharedPreferences: $T');
    }
  }

  /// Looks up the value for the provided [key].
  /// Returns `null` if no value exists for that key.
  T? read<T>({required String key}) {
    final value = _prefs.get(key);
    if (value is T) return value;
    return null;
  }
}
