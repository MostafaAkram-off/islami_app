import 'package:dio/dio.dart';
import 'package:islami_app/model/pray_time_model.dart';
import 'package:islami_app/model/radio_model.dart';
import 'package:islami_app/model/reciter_model.dart';

abstract class ApiManager {
  static const String prayTimeBaseUrl = "https://api.aladhan.com";

  /// لازم الـ www وإلا السيرفر بيرد بـ 301
  static const String quranBaseUrl = "https://www.mp3quran.net";

  /// لغة أسامي الإذاعات والقُرّاء — الديزاين متعمل بالإنجليزي
  static const String language = "en";

  /// المدينة اللي بتتجاب ليها المواقيت — لو حبيت تغيرها غيرها من هنا
  static const String city = "cairo";
  static const String country = "egypt";

  static final Dio _prayTimeDio = Dio(
    BaseOptions(
      baseUrl: prayTimeBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static final Dio _quranDio = Dio(
    BaseOptions(
      baseUrl: quranBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static Future<PrayTimeModel> getPrayTimes() async {
    DateTime now = DateTime.now();
    String date =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    Response response = await _prayTimeDio.get(
      "/v1/timingsByCity/$date",
      queryParameters: {"city": city, "country": country},
    );

    return PrayTimeModel.fromJson(response.data["data"]);
  }

  static Future<List<RadioModel>> getRadios() async {
    Response response = await _quranDio.get(
      "/api/v3/radios",
      queryParameters: {"language": language},
    );

    return (response.data["radios"] as List)
        .map((radio) => RadioModel.fromJson(radio))
        .toList();
  }

  static Future<List<ReciterModel>> getReciters() async {
    Response response = await _quranDio.get(
      "/api/v3/reciters",
      queryParameters: {"language": language},
    );

    return (response.data["reciters"] as List)
        .map((reciter) => ReciterModel.fromJson(reciter))
        .toList();
  }
}
