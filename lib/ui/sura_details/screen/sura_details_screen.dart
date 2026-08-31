import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SuraModel sura = ModalRoute.of(context)!.settings.arguments as SuraModel;
      readSuraFile(sura.suraNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    SuraModel sura = ModalRoute.of(context)?.settings.arguments as SuraModel;
    return Scaffold(
      backgroundColor: ColorsManger.blackColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorsManger.goldColor),
        centerTitle: true,
        title: Text(sura.suraNameEn, style: TextStyles.smallTitleTextStyle()),
      ),
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
            Expanded(
              child: suraVerses.isNotEmpty
                  ? SingleChildScrollView(
                      child: Text(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        suraVerses,
                        style: TextStyle(
                          height: 2.5,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: ColorsManger.goldColor,
                          fontFamily: "Janna",
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: ColorsManger.goldColor,
                      ),
                    ),
            ),
            Image.asset(AssetsManger.suraMosque),
          ],
        ),
      ),
    );
  }

  String suraVerses = "";

  Future<void> readSuraFile(int suraNumber) async {
    String suraText = await rootBundle.loadString(
      "assets/suras/$suraNumber.txt",
    );
    List<String> suraLines = suraText.split("\n");
    for (int i = 0; i < suraLines.length; i++) {
      suraVerses = suraVerses + suraLines[i].trim();
      suraVerses = suraVerses + "(${i + 1})";
    }
    setState(() {});
  }
}
