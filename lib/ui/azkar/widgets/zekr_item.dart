import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/zekr_model.dart';

/// كارت الذكر الواحد — دوس عليه يعدّ مرة، ولما يكمل عدده بيتعلّم بعلامة صح
class ZekrItem extends StatelessWidget {
  final ZekrModel zekr;
  final int counter;
  final VoidCallback onTap;

  const ZekrItem({
    super.key,
    required this.zekr,
    required this.counter,
    required this.onTap,
  });

  bool get isDone => counter >= zekr.count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDone ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsManger.blackColor.withValues(alpha: isDone ? 0.35 : 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDone
                ? ColorsManger.goldColor.withValues(alpha: 0.35)
                : ColorsManger.goldColor,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text(
              zekr.text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyles.largeBodyTextStyle(
                textColor: isDone
                    ? ColorsManger.offWhiteColor.withValues(alpha: 0.5)
                    : ColorsManger.offWhiteColor,
              ).copyWith(height: 1.9),
            ),
            Divider(
              height: 1,
              color: ColorsManger.goldColor.withValues(alpha: 0.4),
            ),
            buildCounter(),
          ],
        ),
      ),
    );
  }

  Widget buildCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        if (isDone)
          const Icon(
            Icons.check_circle,
            color: ColorsManger.goldColor,
            size: 22,
          )
        else
          const Icon(
            Icons.touch_app_outlined,
            color: ColorsManger.goldColor,
            size: 22,
          ),
        // أرقام لاتينية عشان الواجهة إنجليزي، والأرقام العربية جنب نص
        // إنجليزي بيتقلب ترتيبها بسبب الـ bidi
        Text(
          "$counter / ${zekr.count}",
          style: TextStyles.mediumLabelTextStyle(),
        ),
      ],
    );
  }
}
