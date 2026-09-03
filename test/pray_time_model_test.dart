import 'package:flutter_test/flutter_test.dart';
import 'package:islami_app/model/pray_time_model.dart';

void main() {
  /// نفس شكل الـ data اللي بترجع من api.aladhan.com
  Map<String, dynamic> apiResponse({
    String fajr = "05:03",
    String sunrise = "06:33",
    String dhuhr = "12:54",
    String asr = "16:29",
    String maghrib = "19:15",
    String isha = "20:35",
  }) => {
    "timings": {
      "Fajr": fajr,
      "Sunrise": sunrise,
      "Dhuhr": dhuhr,
      "Asr": asr,
      "Maghrib": maghrib,
      "Isha": isha,
    },
    "date": {
      "gregorian": {
        "day": "03",
        "month": {"en": "September"},
        "year": "2026",
        "weekday": {"en": "Thursday"},
      },
      "hijri": {
        "day": "21",
        "month": {"en": "Rabīʿ al-awwal"},
        "year": "1448",
      },
    },
  };

  group("PrayTimeModel.fromJson", () {
    test("keeps the six displayed prayers in order", () {
      PrayTimeModel prayTime = PrayTimeModel.fromJson(apiResponse());
      expect(prayTime.prayers.map((prayer) => prayer.name).toList(), [
        "Fajr",
        "Sunrise",
        "Dhuhr",
        "ASR",
        "Maghrib",
        "Isha",
      ]);
    });

    test("shortens the month names and formats both dates", () {
      PrayTimeModel prayTime = PrayTimeModel.fromJson(apiResponse());
      expect(prayTime.gregorianDate, "03 Sep, 2026");
      expect(prayTime.hijriDate, "21 Rab, 1448");
      expect(prayTime.weekDay, "Thursday");
    });

    test("ignores a timezone suffix on a timing", () {
      PrayTimeModel prayTime = PrayTimeModel.fromJson(
        apiResponse(fajr: "05:03 (EET)"),
      );
      expect(prayTime.prayers.first.time.hour, 5);
      expect(prayTime.prayers.first.time.minute, 3);
    });
  });

  group("PrayerModel formatting", () {
    PrayerModel prayerAt(int hour, int minute) =>
        PrayerModel(name: "Test", time: DateTime(2026, 9, 3, hour, minute));

    test("shows afternoon times on a twelve hour clock", () {
      expect(prayerAt(16, 29).formattedTime, "04:29");
      expect(prayerAt(16, 29).period, "PM");
    });

    test("shows midnight as twelve AM, not zero", () {
      expect(prayerAt(0, 15).formattedTime, "12:15");
      expect(prayerAt(0, 15).period, "AM");
    });

    test("shows noon as twelve PM", () {
      expect(prayerAt(12, 0).formattedTime, "12:00");
      expect(prayerAt(12, 0).period, "PM");
    });
  });

  group("PrayTimeModel.nextPrayer", () {
    test("is the first prayer still ahead of now", () {
      DateTime now = DateTime.now();
      PrayTimeModel prayTime = PrayTimeModel.fromJson(
        apiResponse(
          fajr: "00:01",
          sunrise: "00:02",
          dhuhr: "23:58",
          asr: "23:59",
        ),
      );
      // الفجر والشروق عدّوا خلاص، فالجاية هي الظهر
      expect(prayTime.nextPrayer.name, "Dhuhr");
      expect(prayTime.nextPrayer.time.isAfter(now), isTrue);
    });

    test("falls back to tomorrow's first prayer once the day is over", () {
      PrayTimeModel prayTime = PrayTimeModel.fromJson(
        apiResponse(
          fajr: "00:01",
          sunrise: "00:02",
          dhuhr: "00:03",
          asr: "00:04",
          maghrib: "00:05",
          isha: "00:06",
        ),
      );
      expect(prayTime.nextPrayer.name, "Fajr");
      expect(prayTime.nextPrayer.time.isAfter(DateTime.now()), isTrue);
      expect(prayTime.timeToNextPrayer.isNegative, isFalse);
    });

    // العداد بيقارن الصلاة الجاية بالقديمة كل ثانية، ولو المقارنة بالمرجع
    // كل تيك هيبان كأنه صلاة اتغيرت لأن الرجوع لفجر بكرة بيبني كائن جديد
    test("returns an equal value on repeated calls after the day is over", () {
      PrayTimeModel prayTime = PrayTimeModel.fromJson(
        apiResponse(
          fajr: "00:01",
          sunrise: "00:02",
          dhuhr: "00:03",
          asr: "00:04",
          maghrib: "00:05",
          isha: "00:06",
        ),
      );
      expect(prayTime.nextPrayer, prayTime.nextPrayer);
    });
  });
}
