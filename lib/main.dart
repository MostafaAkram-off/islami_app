import 'package:flutter/material.dart';
import 'package:islami_app/core/local/prefs_manager.dart';
import 'package:islami_app/core/resources/app_theme.dart';
import 'package:islami_app/ui/hadeth_details/screen/hadeth_details_screen.dart';
import 'package:islami_app/ui/home/screen/home_screen.dart';
import 'package:islami_app/ui/onboarding/screen/onboarding_screen.dart';
import 'package:islami_app/ui/sura_details/screen/sura_details_screen.dart';

import 'core/resources/routes_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  runApp(const Islami());
}

class Islami extends StatelessWidget {
  const Islami({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routes: {
        RoutesManger.onBoardingRouteName: (context) => const OnboardingScreen(),
        RoutesManger.homeRouteName: (context) => const HomeScreen(),
        RoutesManger.suraDetailsRouteName: (context) =>
            const SuraDetailsScreen(),
        RoutesManger.hadethDetailsRouteName: (context) =>
            const HadethDetailsScreen(),
      },
      initialRoute: PrefsManager.getOnboardingViewed()
          ? RoutesManger.homeRouteName
          : RoutesManger.onBoardingRouteName,
    );
  }
}
