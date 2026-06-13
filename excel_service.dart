import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ExcelService {
  static const Map<String, String> fileMap = {
    '5L': 'assets/excel/5L.xlsx',
    '3L': 'assets/excel/3L.xlsx',
    '2L': 'assets/excel/2L.xlsx',
  };

  static Future<List<String>> getSheetNames(
      String category,
      ) async {
    try {
      final path = fileMap[category];

      if (path == null) return [];

      final ByteData data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();

      final excel = Excel.decodeBytes(bytes);

      return excel.tables.keys.toList();
    } catch (e) {
      debugPrint('Sheet Name Error: $e');
      return [];
    }
  }

  static Future<List<List<String>>> getSheetData({
    required String category,
    required String sheetName,
  }) async {
    try {
      final path = fileMap[category];

      if (path == null) return [];

      final ByteData data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();

      final excel = Excel.decodeBytes(bytes);

      final sheet = excel.tables[sheetName];

      if (sheet == null) return [];

      return sheet.rows.map((row) {
        return row.map((cell) {
          return cell?.value?.toString() ?? '';
        }).toList();
      }).toList();
    } catch (e) {
      debugPrint('Sheet Data Error: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchMember(
      String keyword,
      ) async {
    final List<Map<String, dynamic>> results = [];

    if (keyword.trim().isEmpty) {
      return results;
    }

    try {
      final searchText = keyword.toLowerCase();

      for (final entry in fileMap.entries) {
        final category = entry.key;
        final path = entry.value;

        final ByteData data = await rootBundle.load(path);
        final bytes = data.buffer.asUint8List();

        final excel = Excel.decodeBytes(bytes);

        for (final sheetName in excel.tables.keys) {
          final sheet = excel.tables[sheetName];

          if (sheet == null) continue;

          for (int rowIndex = 0;
          rowIndex < sheet.rows.length;
          rowIndex++) {
            final row = sheet.rows[rowIndex];

            for (final cell in row) {
              final value =
                  cell?.value?.toString().toLowerCase() ?? '';

              if (value.contains(searchText)) {
                results.add({
                  'category': category,
                  'sheet': sheetName,
                  'row': rowIndex + 1,
                  'value': cell?.value?.toString() ?? '',
                });

                break;
              }
            }
          }
        }
      }

      return results;
    } catch (e) {
      debugPrint('Search Error: $e');
      return [];
    }
  }
}