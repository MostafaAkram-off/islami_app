import 'package:islami_app/model/sura_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveOnBoardingViewed() async {
    await preferences.setBool("is_onboarding_viewed", true);
  }

  static bool getOnboardingViewed() {
    return preferences.getBool("is_onboarding_viewed") ?? false;
  }

  /// أقصى عدد سور بيتحفظ في "Most Recently"
  static const int mostRecentLimit = 10;

  static void saveMostRecent(List<SuraModel> mostRecent) {
    preferences.setStringList(
      "most_recent",
      mostRecent.take(mostRecentLimit).map((sura) => sura.suraNameEn).toList(),
    );
  }

  static void saveSebha(int counter, int azkarIndex) {
    preferences.setInt("sebha_counter", counter);
    preferences.setInt("sebha_azkar_index", azkarIndex);
  }

  static int getSebhaCounter() {
    return preferences.getInt("sebha_counter") ?? 0;
  }

  static int getSebhaAzkarIndex() {
    return preferences.getInt("sebha_azkar_index") ?? 0;
  }

  static List<SuraModel> getMostRecent() {
    List<String> savedNames = preferences.getStringList("most_recent") ?? [];
    List<SuraModel> mostRecent = [];
    for (String name in savedNames) {
      // اسم مش موجود في الليست معناه إن البيانات المحفوظة قديمة، فبنتخطاه
      // بدل ما firstWhere ترمي exception وتوقع التاب
      int index = SuraModel.surasList.indexWhere(
        (sura) => sura.suraNameEn == name,
      );
      if (index != -1) mostRecent.add(SuraModel.surasList[index]);
    }
    return mostRecent;
  }
}
