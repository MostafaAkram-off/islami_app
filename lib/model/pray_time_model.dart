class PrayTimeModel {
  final List<PrayerModel> prayers;

  /// التاريخ الميلادي بالشكل "16 Jul, 2024"
  final String gregorianDate;

  /// التاريخ الهجري بالشكل "09 Muh, 1446"
  final String hijriDate;

  /// اسم اليوم بالإنجليزي زي "Tuesday"
  final String weekDay;

  PrayTimeModel({
    required this.prayers,
    required this.gregorianDate,
    required this.hijriDate,
    required this.weekDay,
  });

  /// أسماء الصلوات اللي بتظهر في الشاشة بترتيب اليوم،
  /// المفتاح زي ما الـ API بيرجعه والقيمة زي ما بتتعرض
  static const Map<String, String> displayedPrayers = {
    "Fajr": "Fajr",
    "Sunrise": "Sunrise",
    "Dhuhr": "Dhuhr",
    "Asr": "ASR",
    "Maghrib": "Maghrib",
    "Isha": "Isha",
  };

  factory PrayTimeModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> timings = json["timings"];
    Map<String, dynamic> date = json["date"];
    Map<String, dynamic> gregorian = date["gregorian"];
    Map<String, dynamic> hijri = date["hijri"];

    return PrayTimeModel(
      prayers: displayedPrayers.entries
          .map(
            (entry) => PrayerModel(
              name: entry.value,
              time: _parseTime(timings[entry.key]),
            ),
          )
          .toList(),
      gregorianDate: _formatDate(gregorian),
      hijriDate: _formatDate(hijri),
      weekDay: gregorian["weekday"]["en"],
    );
  }

  /// الـ API بيرجع الوقت "16:29" وساعات بيزود التوقيت زي "16:29 (EET)"
  static DateTime _parseTime(String apiTime) {
    List<String> parts = apiTime.trim().split(" ").first.split(":");
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  /// بيحول { day: "16", month: { en: "July" }, year: "2024" } لـ "16 Jul, 2024"
  static String _formatDate(Map<String, dynamic> date) {
    String month = date["month"]["en"];
    if (month.length > 3) month = month.substring(0, 3);
    return "${date["day"]} $month, ${date["year"]}";
  }

  /// أول صلاة جاية بعد دلوقتي، ولو اليوم خلص بترجع أول صلاة (الفجر) بتاعة بكرة
  PrayerModel get nextPrayer {
    DateTime now = DateTime.now();
    return prayers.firstWhere(
      (prayer) => prayer.time.isAfter(now),
      orElse: () => PrayerModel(
        name: prayers.first.name,
        time: prayers.first.time.add(const Duration(days: 1)),
      ),
    );
  }

  /// الوقت الفاضل على الصلاة الجاية
  Duration get timeToNextPrayer => nextPrayer.time.difference(DateTime.now());
}

class PrayerModel {
  final String name;
  final DateTime time;

  PrayerModel({required this.name, required this.time});

  // nextPrayer بترجع كائن جديد لما اليوم يخلص وترجع فجر بكرة، فالمقارنة
  // لازم تبقى بالقيمة مش بالمرجع وإلا كل تيك هيبان كأنه صلاة اتغيرت
  @override
  bool operator ==(Object other) =>
      other is PrayerModel && other.name == name && other.time == time;

  @override
  int get hashCode => Object.hash(name, time);

  /// الوقت بصيغة 12 ساعة زي "04:38"
  String get formattedTime {
    int hour = time.hour % 12;
    if (hour == 0) hour = 12;
    return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String get period => time.hour < 12 ? "AM" : "PM";
}
