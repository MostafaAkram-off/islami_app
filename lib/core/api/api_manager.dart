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

  /// المدينة اللي بترجع لها المواقيت لو الموقع مش متاح
  static const String fallbackCity = "cairo";
  static const String fallbackCountry = "egypt";

  /// طريقة حساب المواقيت: الهيئة المصرية العامة للمساحة
  static const int calculationMethod = 5;

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

  /// بتجيب مواقيت النهاردة على إحداثيات الجهاز، ولو [latitude] أو
  /// [longitude] مش موجودين بترجع لمواقيت المدينة الافتراضية
  static Future<PrayTimeModel> getPrayTimes({
    double? latitude,
    double? longitude,
  }) async {
    DateTime now = DateTime.now();
    String date =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    bool hasLocation = latitude != null && longitude != null;

    Response response = await _prayTimeDio.get(
      hasLocation ? "/v1/timings/$date" : "/v1/timingsByCity/$date",
      queryParameters: hasLocation
          ? {
              "latitude": latitude,
              "longitude": longitude,
              "method": calculationMethod,
            }
          : {"city": fallbackCity, "country": fallbackCountry},
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
