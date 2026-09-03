import 'package:dio/dio.dart';
import 'package:islami_app/model/pray_time_model.dart';

abstract class ApiManager {
  static const String prayTimeBaseUrl = "https://api.aladhan.com";

  /// المدينة اللي بتتجاب ليها المواقيت — لو حبيت تغيرها غيرها من هنا
  static const String city = "cairo";
  static const String country = "egypt";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: prayTimeBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static Future<PrayTimeModel> getPrayTimes() async {
    DateTime now = DateTime.now();
    String date =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    Response response = await _dio.get(
      "/v1/timingsByCity/$date",
      queryParameters: {"city": city, "country": country},
    );

    return PrayTimeModel.fromJson(response.data["data"]);
  }
}
