import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const SizedBox(height: 16),
        Image.asset(AssetsManger.imageHeader, height: screenHeight * 0.14),
        const Spacer(),
        Image.asset(
          model.imagePath,
          height: screenHeight * 0.35,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: TextStyles.largeTitleTextStyle(
            textColor: ColorsManger.goldColor,
          ),
        ),
        if (model.body != null) ...[
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              model.body!,
              textAlign: TextAlign.center,
              style: TextStyles.largeBodyTextStyle(
                textColor: ColorsManger.goldColor,
              ),
            ),
          ),
        ],
        const Spacer(),
      ],
    );
  }
}
