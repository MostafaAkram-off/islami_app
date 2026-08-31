import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';

class MostRecentItem extends StatelessWidget {
  const MostRecentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManger.goldColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Al-Anbiya",
                  style: TextStyles.largeLabelTextStyle(
                    textColor: ColorsManger.blackColor,
                  ),
                ),
                Text(
                  "الأنبياء",
                  style: TextStyles.largeLabelTextStyle(
                    textColor: ColorsManger.blackColor,
                  ),
                ),
                Text(
                  "112 Verses",
                  style: TextStyles.mediumBodyTextStyle(
                    textColor: ColorsManger.blackColor,
                  ),
                ),
              ],
            ),
            Image.asset(AssetsManger.mostRecentBack),
          ],
        ),
      ),
    );
  }
}
