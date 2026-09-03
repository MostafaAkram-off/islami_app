abstract class ArabicNumbers {
  static const List<String> _digits = [
    "٠",
    "١",
    "٢",
    "٣",
    "٤",
    "٥",
    "٦",
    "٧",
    "٨",
    "٩",
  ];

  /// بيحول 173 لـ "١٧٣" عشان أرقام الآيات تبقى بنفس شكل النص العربي
  static String format(int number) {
    return number
        .toString()
        .split("")
        .map((digit) => _digits[int.parse(digit)])
        .join();
  }
}
