import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// بيرجع موقع الجهاز، وnull لو الخدمة مقفولة أو المستخدم رفض الإذن
  /// أو حصلت أي مشكلة — المواقيت بترجع للمدينة الافتراضية في الحالة دي
  static Future<Position?> getPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // آخر موقع معروف كفاية تماماً للمواقيت وبيرجع فوراً من غير
      // ما نفضل مستنيين الـ GPS يشتغل
      Position? lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) return lastKnown;

      // دقة منخفضة كفاية وبتوفر بطارية
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } catch (_) {
      return null;
    }
  }
}
