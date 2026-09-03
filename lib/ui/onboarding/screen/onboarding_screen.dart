import 'package:flutter/material.dart';
import 'package:islami_app/core/local/prefs_manager.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/routes_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/onboarding_model.dart';
import 'package:islami_app/ui/onboarding/widgets/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void finishOnboarding() {
    PrefsManager.saveOnBoardingViewed();
    Navigator.pushReplacementNamed(context, RoutesManger.homeRouteName);
  }

  @override
  Widget build(BuildContext context) {
    var onboardingList = OnboardingModel.onBoardingList;
    return Scaffold(
      backgroundColor: ColorsManger.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingList.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItem(model: onboardingList[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: currentIndex > 0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: TextButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        StringsManger.back,
                        style: TextStyles.smallBodyTextStyle(
                          textColor: ColorsManger.goldColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      onboardingList.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: currentIndex == index ? 18 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? ColorsManger.goldColor
                              : ColorsManger.greyColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (currentIndex == onboardingList.length - 1) {
                        finishOnboarding();
                      } else {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      currentIndex == onboardingList.length - 1
                          ? StringsManger.finish
                          : StringsManger.next,
                      style: TextStyles.smallLabelTextStyle(
                        textColor: ColorsManger.goldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
