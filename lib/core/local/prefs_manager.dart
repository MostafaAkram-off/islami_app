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

  static saveMostRecent(List<SuraModel> mostRecent) {
    preferences.setStringList(
      "most_recent",
      mostRecent.map((sura) => sura.suraNameEn).toList(),
    );
  }

  static List<SuraModel> getMostRecent() {
    List<String> mostRecentString =
        preferences.getStringList("most_recent") ?? [];
    List<SuraModel> mostRecent = [];
    for (int i = 0; i < mostRecentString.length; i++) {
      SuraModel sura = SuraModel.surasList.firstWhere(
        (sura) => sura.suraNameEn == mostRecentString[i],
      );
      mostRecent.add(sura);
    }
    return mostRecent;
  }
}
