import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  /// التابات اللي المستخدم فتحها فعلاً. الـ IndexedStack بيبني كل عياله
  /// مرة واحدة، وده كان معناه إن التطبيق أول ما يفتح يضرب ٣ ريكوستات
  /// ويطلب إذن الموقع وانت لسه على تاب القرآن
  final Set<int> visitedTabs = {0};

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

  void onDestinationSelected(int index) {
    if (index == selectedIndex) return;
    HapticFeedback.selectionClick();
    setState(() {
      selectedIndex = index;
      visitedTabs.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsManger.blackColor,
      bottomNavigationBar: buildNavigationBar(),
      // IndexedStack بيحافظ على حالة كل تاب (الراديو يفضل شغال والمواقيت
      // متتجابش تاني)، والـ TweenAnimationBuilder بيدخّل التاب الجديد بـ fade
      // من غير ما يعيد بناء الـ stack نفسه فالحالة بتفضل موجودة
      body: TweenAnimationBuilder<double>(
        key: ValueKey<int>(selectedIndex),
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 10),
            child: child,
          ),
        ),
        child: IndexedStack(
          index: selectedIndex,
          children: List.generate(
            tabs.length,
            // التاب بيتبنى أول ما تفتحه، وبعدها بيفضل عايش عشان حالته تتحفظ
            (index) => visitedTabs.contains(index)
                ? tabs[index]
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget buildNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          backgroundColor: ColorsManger.goldColor,
          animationDuration: const Duration(milliseconds: 450),
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
      ),
    );
  }

  Widget buildTabIcon(String asset, Color color) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
