import 'package:flutter_test/flutter_test.dart';
import 'package:islami_app/model/azkar_model.dart';
import 'package:islami_app/model/zekr_model.dart';

void main() {
  group("AzkarModel", () {
    test("both lists have the same length", () {
      expect(AzkarModel.morning.length, AzkarModel.evening.length);
    });

    test("only the first two azkar differ between morning and evening", () {
      List<ZekrModel> morningShared = AzkarModel.morning.skip(2).toList();
      List<ZekrModel> eveningShared = AzkarModel.evening.skip(2).toList();
      for (int i = 0; i < morningShared.length; i++) {
        expect(morningShared[i].text, eveningShared[i].text);
      }
      expect(
        AzkarModel.morning.first.text,
        isNot(AzkarModel.evening.first.text),
      );
    });

    test("the time specific azkar mention the right time of day", () {
      expect(AzkarModel.morning.first.text, contains("أَصْبَحْنَا"));
      expect(AzkarModel.evening.first.text, contains("أَمْسَيْنَا"));
    });

    test("every zekr has text and is repeated at least once", () {
      for (ZekrModel zekr in [...AzkarModel.morning, ...AzkarModel.evening]) {
        expect(zekr.text.trim(), isNotEmpty);
        expect(zekr.count, greaterThanOrEqualTo(1));
      }
    });
  });
}
