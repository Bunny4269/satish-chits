import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static late Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('chit_data');
  }

  // Save admin password
  static Future<void> saveAdminPassword(
      String password,
      ) async {
    await box.put('admin_password', password);
  }

  // Get admin password
  static String getAdminPassword() {
    return box.get(
      'admin_password',
      defaultValue: '1234',
    );
  }

  // Save group data
  static Future<void> saveGroup(
      String groupName,
      Map<String, dynamic> data,
      ) async {
    await box.put(groupName, data);
  }

  // Get group data
  static Map<String, dynamic>? getGroup(
      String groupName,
      ) {
    final data = box.get(groupName);

    if (data == null) return null;

    return _convertMap(data);
  }

  static Map<String, dynamic> _convertMap(
      Map<dynamic, dynamic> map,
      ) {
    return map.map(
          (key, value) {
        if (value is Map) {
          return MapEntry(
            key.toString(),
            _convertMap(
              Map<dynamic, dynamic>.from(value),
            ),
          );
        }

        if (value is List) {
          return MapEntry(
            key.toString(),
            value.map((item) {
              if (item is Map) {
                return _convertMap(
                  Map<dynamic, dynamic>.from(item),
                );
              }
              return item;
            }).toList(),
          );
        }

        return MapEntry(
          key.toString(),
          value,
        );
      },
    );
  }

  // Clear history if needed
  static Future<void> clearHistory() async {
    await box.delete('history');
  }
}