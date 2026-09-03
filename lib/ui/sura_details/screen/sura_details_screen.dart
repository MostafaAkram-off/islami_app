import 'package:flutter/material.dart';
import 'package:islami_app/core/local/text_assets.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/core/utils/arabic_numbers.dart';
import 'package:islami_app/model/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  String suraVerses = "";
  bool hasError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (suraVerses.isEmpty && !hasError) {
      SuraModel sura = ModalRoute.of(context)!.settings.arguments as SuraModel;
      readSuraFile(sura.suraNumber);
    }
  }

  Future<void> readSuraFile(int suraNumber) async {
    try {
      List<String> verses = await TextAssets.readLines(
        "assets/suras/$suraNumber.txt",
      );
      String text = "";
      for (int i = 0; i < verses.length; i++) {
        text += "${verses[i]} (${ArabicNumbers.format(i + 1)}) ";
      }
      if (mounted) setState(() => suraVerses = text.trim());
    } catch (_) {
      if (mounted) setState(() => hasError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    SuraModel sura = ModalRoute.of(context)!.settings.arguments as SuraModel;
    return Scaffold(
      appBar: AppBar(title: Text(sura.suraNameEn)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AssetsManger.leftCorner),
                Text(sura.suraNameAr, style: TextStyles.largeTitleTextStyle()),
                Image.asset(AssetsManger.rightCorner),
              ],
            ),
            Expanded(child: buildBody()),
            Image.asset(AssetsManger.suraMosque),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    if (hasError) {
      return Center(
        child: Text(
          StringsManger.somethingWentWrong,
          style: TextStyles.largeBodyTextStyle(),
        ),
      );
    }
    if (suraVerses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Text(
        suraVerses,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: TextStyles.suraVerseTextStyle(),
      ),
    );
  }
}
