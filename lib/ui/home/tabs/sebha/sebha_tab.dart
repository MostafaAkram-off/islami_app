import 'package:flutter/material.dart';
import 'package:islami_app/core/local/prefs_manager.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/ui/home/tabs/sebha/widgets/sebha_beads.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  /// عدد الخرزات الموجودة فعلياً في صورة السبحة، اللفة بتتقسم عليه
  /// عشان كل ضغطة تحرك خرزة واحدة بالظبط تحت الرأس
  static const int beadsCount = 30;

  /// عدد التسبيحات قبل ما الذكر يتغير
  static const int tasbeehTarget = 33;

  int counter = PrefsManager.getSebhaCounter();
  int azkarIndex = PrefsManager.getSebhaAzkarIndex();
  late double turns = counter / beadsCount;

  void onSebhaTap() {
    setState(() {
      turns += 1 / beadsCount;
      if (counter == tasbeehTarget) {
        counter = 1;
        azkarIndex = (azkarIndex + 1) % StringsManger.azkar.length;
      } else {
        counter++;
      }
    });
    PrefsManager.saveSebha(counter, azkarIndex);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManger.sebhaBack),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            Image.asset(
              AssetsManger.imageHeader,
              height: screenHeight * 0.15,
              fit: BoxFit.fitHeight,
            ),
            Text(
              StringsManger.sebhaAyah,
              textAlign: TextAlign.center,
              style: TextStyles.largeTitleTextStyle(
                textColor: ColorsManger.whiteColor,
              ),
            ),
            Expanded(
              child: SebhaBeads(
                turns: turns,
                counter: counter,
                zekr: StringsManger.azkar[azkarIndex],
                onTap: onSebhaTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
