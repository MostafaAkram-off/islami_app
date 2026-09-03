import 'package:flutter/services.dart';

abstract class TextAssets {
  /// ملفات السور والأحاديث متسجلة بـ CRLF وبـ BOM في أولها،
  /// فلازم تتنضف قبل ما تتعرض وإلا بيظهر رقم آية زيادة في آخر السورة
  /// وبيتسرب محرف مخفي في عنوان الحديث
  static Future<List<String>> readLines(String path) async {
    String content = await rootBundle.loadString(path);
    return content
        .replaceFirst("\uFEFF", "")
        .split("\n")
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }
}
