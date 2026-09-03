import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';

class SebhaBeads extends StatelessWidget {
  final double turns;
  final int counter;
  final String zekr;
  final VoidCallback onTap;

  const SebhaBeads({
    super.key,
    required this.turns,
    required this.counter,
    required this.zekr,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Semantics(
      button: true,
      label: StringsManger.countTasbeeh,
      value: "$zekr $counter",
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManger.sebhaHead,
              width: screenWidth * 0.28,
              fit: BoxFit.fitWidth,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Image.asset(
                    AssetsManger.sebhaBody,
                    width: screenWidth * 0.68,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    Text(zekr, style: TextStyles.largeTitleTextStyle()),
                    // الرقم بيدخل بـ scale صغير مع كل ضغطة
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: Tween<double>(begin: 0.7, end: 1).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutBack,
                          ),
                        ),
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: Text(
                        "$counter",
                        key: ValueKey<int>(counter),
                        style: TextStyles.largeTitleTextStyle(
                          textColor: ColorsManger.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
