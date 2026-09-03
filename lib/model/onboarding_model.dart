import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';

class OnboardingModel {
  final String imagePath;
  final String title;
  final String? body;

  const OnboardingModel({
    required this.imagePath,
    required this.title,
    this.body,
  });

  static List<OnboardingModel> onBoardingList = [
    const OnboardingModel(
      imagePath: AssetsManger.onboarding1,
      title: StringsManger.welcomeToIslmiApp,
    ),
    const OnboardingModel(
      imagePath: AssetsManger.onboarding2,
      title: StringsManger.welcomeToIslmi,
      body: StringsManger.onboardingBody1,
    ),
    const OnboardingModel(
      imagePath: AssetsManger.onboarding3,
      title: StringsManger.readingTheQuran,
      body: StringsManger.onboardingBody2,
    ),
    const OnboardingModel(
      imagePath: AssetsManger.onboarding4,
      title: StringsManger.bearish,
      body: StringsManger.onboardingBody3,
    ),
    const OnboardingModel(
      imagePath: AssetsManger.onboarding5,
      title: StringsManger.holyQuranRadio,
      body: StringsManger.onboardingBody4,
    ),
  ];
}
