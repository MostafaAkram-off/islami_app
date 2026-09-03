import 'package:flutter_test/flutter_test.dart';
import 'package:islami_app/core/utils/arabic_numbers.dart';

void main() {
  group("ArabicNumbers.format", () {
    test("converts a single digit", () {
      expect(ArabicNumbers.format(0), "٠");
      expect(ArabicNumbers.format(7), "٧");
    });

    test("converts a multi digit number keeping the order", () {
      expect(ArabicNumbers.format(173), "١٧٣");
      expect(ArabicNumbers.format(286), "٢٨٦");
    });

    test("keeps repeated digits", () {
      expect(ArabicNumbers.format(111), "١١١");
    });
  });
}
