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
  List<Widget> tabs = [
    QuranTab(),
    HadethTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsManger.blackColor,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex  ,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        backgroundColor: ColorsManger.goldColor,
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          return TextStyles.mediumBodyTextStyle();
        }),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: ColorsManger.blackColor.withValues(alpha: 0.6),
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              AssetsManger.quranTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.blackColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              AssetsManger.quranTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManger.quran,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              AssetsManger.hadethTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.blackColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              AssetsManger.hadethTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManger.hadith,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              AssetsManger.sebhaTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.blackColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              AssetsManger.sebhaTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManger.sebha,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              AssetsManger.radioTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.blackColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              AssetsManger.radioTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManger.radio,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              AssetsManger.timeTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.blackColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              AssetsManger.timeTab,
              colorFilter: ColorFilter.mode(
                ColorsManger.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManger.time,
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
