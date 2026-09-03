import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/model/pray_time_model.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// تذكير بكل صلاة في معادها.
/// الإشعارات بتتجدول من أول ما المواقيت توصل، وبتتلغي كلها لما
/// المستخدم يقفل التذكير من زرار الكتم في كارت المواقيت
abstract class NotificationService {
  static const String _channelId = "prayer_times";

  /// الشروق مش صلاة، فمش بيتجدول ليه تذكير
  static const String _sunrise = "Sunrise";

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(await _deviceTimeZone()));

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      ),
    );
    _initialized = true;
  }

  /// بيرجع اسم المنطقة الزمنية للجهاز، ولو مقدرش بيرجع UTC عشان
  /// الجدولة تفضل شغالة بدل ما ترمي
  static Future<String> _deviceTimeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (_) {
      return "UTC";
    }
  }

  /// بيطلب إذن الإشعارات ويرجع هل المستخدم وافق
  static Future<bool> requestPermission() async {
    await init();

    bool? android = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    bool? ios = await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, sound: true);

    return android ?? ios ?? false;
  }

  /// بيلغي أي تذكيرات قديمة ويجدول صلوات النهاردة اللي لسه جاية
  static Future<void> schedulePrayers(PrayTimeModel prayTime) async {
    await init();
    await cancelAll();

    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    for (int i = 0; i < prayTime.prayers.length; i++) {
      PrayerModel prayer = prayTime.prayers[i];
      if (prayer.name == _sunrise) continue;

      tz.TZDateTime at = tz.TZDateTime.from(prayer.time, tz.local);
      if (!at.isAfter(now)) continue;

      await _plugin.zonedSchedule(
        i,
        StringsManger.prayerReminderTitle,
        "${StringsManger.prayerReminderBody} ${prayer.name}",
        at,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            StringsManger.prayerReminderChannel,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        // inexact عشان ميحتاجش إذن SCHEDULE_EXACT_ALARM اللي جوجل
        // مقيّداه؛ التذكير ممكن يتأخر دقيقة أو اتنين في وضع التوفير
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  static Future<void> cancelAll() async {
    await init();
    await _plugin.cancelAll();
  }

  /// بترجع التذكيرات المجدولة حالياً — بتستخدم في التأكد من الجدولة
  static Future<List<PendingNotificationRequest>> pending() async {
    await init();
    return _plugin.pendingNotificationRequests();
  }
}
