import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/ui/home/tabs/hadeth/hadeth_tab.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_tab.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_tab.dart';
import 'package:islami_app/ui/home/tabs/sebha/sebha_tab.dart';
import 'package:islami_app/ui/home/tabs/time/time_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static const List<Widget> tabs = [
    QuranTab(),
    HadethTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab(),
  ];

  static const List<({String icon, String label})> destinations = [
    (icon: AssetsManger.quranTab, label: StringsManger.quran),
    (icon: AssetsManger.hadethTab, label: StringsManger.hadith),
    (icon: AssetsManger.sebhaTab, label: StringsManger.sebha),
    (icon: AssetsManger.radioTab, label: StringsManger.radio),
    (icon: AssetsManger.timeTab, label: StringsManger.time),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsManger.blackColor,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() => selectedIndex = value),
        backgroundColor: ColorsManger.goldColor,
        labelTextStyle: WidgetStateTextStyle.resolveWith(
          (states) => TextStyles.mediumBodyTextStyle(),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: ColorsManger.blackColor.withValues(alpha: 0.6),
        destinations: destinations
            .map(
              (destination) => NavigationDestination(
                icon: buildTabIcon(destination.icon, ColorsManger.blackColor),
                selectedIcon: buildTabIcon(
                  destination.icon,
                  ColorsManger.whiteColor,
                ),
                label: destination.label,
              ),
            )
            .toList(),
      ),
      // IndexedStack بدل ما نبني التاب من أول وجديد كل مرة، عشان الراديو
      // يفضل شغال لما تخرج من التاب والمواقيت متتجابش من الـ API كل مرة
      body: IndexedStack(index: selectedIndex, children: tabs),
    );
  }

  Widget buildTabIcon(String asset, Color color) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
