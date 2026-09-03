import 'package:flutter_test/flutter_test.dart';
import 'package:islami_app/model/reciter_model.dart';

void main() {
  Map<String, dynamic> reciterJson() => {
    "id": 1,
    "name": "Ibrahim Al-Akdar",
    "moshaf": [
      {
        "name": "Hafs",
        "server": "https://server6.mp3quran.net/akdr/",
        "surah_list": "1,2,3,114",
      },
    ],
  };

  group("MoshafModel", () {
    test("parses the surah list into numbers", () {
      ReciterModel reciter = ReciterModel.fromJson(reciterJson());
      expect(reciter.moshaf.single.surahList, [1, 2, 3, 114]);
    });

    test("pads the surah number to three digits in the track url", () {
      ReciterModel reciter = ReciterModel.fromJson(reciterJson());
      expect(
        reciter.moshaf.single.surahUrl(1),
        "https://server6.mp3quran.net/akdr/001.mp3",
      );
      expect(
        reciter.moshaf.single.surahUrl(114),
        "https://server6.mp3quran.net/akdr/114.mp3",
      );
    });
  });

  group("ReciterModel.firstSurahUrl", () {
    test("points at the first surah of the first moshaf", () {
      ReciterModel reciter = ReciterModel.fromJson(reciterJson());
      expect(
        reciter.firstSurahUrl,
        "https://server6.mp3quran.net/akdr/001.mp3",
      );
    });

    test("is null when the reciter has no moshaf", () {
      Map<String, dynamic> json = reciterJson()..["moshaf"] = [];
      expect(ReciterModel.fromJson(json).firstSurahUrl, isNull);
    });
  });
}
