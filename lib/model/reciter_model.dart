class ReciterModel {
  final int id;
  final String name;
  final List<MoshafModel> moshaf;

  ReciterModel({required this.id, required this.name, required this.moshaf});

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    return ReciterModel(
      id: json["id"],
      name: json["name"],
      moshaf: (json["moshaf"] as List)
          .map((moshaf) => MoshafModel.fromJson(moshaf))
          .toList(),
    );
  }

  /// لينك أول سورة في أول مصحف للشيخ — ده اللي بيتشغل لما تدوس Play
  String? get firstSurahUrl {
    if (moshaf.isEmpty || moshaf.first.surahList.isEmpty) return null;
    return moshaf.first.surahUrl(moshaf.first.surahList.first);
  }
}

class MoshafModel {
  final String name;

  /// السيرفر اللي بتتحمل منه السور، بينتهي بـ "/"
  final String server;

  /// أرقام السور المتاحة للشيخ في المصحف ده
  final List<int> surahList;

  MoshafModel({
    required this.name,
    required this.server,
    required this.surahList,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) {
    return MoshafModel(
      name: json["name"],
      server: json["server"],
      surahList: (json["surah_list"] as String)
          .split(",")
          .where((surah) => surah.trim().isNotEmpty)
          .map((surah) => int.parse(surah.trim()))
          .toList(),
    );
  }

  /// الملفات على السيرفر مسمّاة برقم السورة من 3 خانات زي "001.mp3"
  String surahUrl(int surahNumber) =>
      "$server${surahNumber.toString().padLeft(3, '0')}.mp3";
}
