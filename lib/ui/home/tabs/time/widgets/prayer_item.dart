import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/pray_time_model.dart';

/// كارت الصلاة الواحدة جوه الليست الأفقية،
/// الصلاة الجاية بتبقى [isNext] فبتتعرض أبيض وأطول من الباقي
class PrayerItem extends StatelessWidget {
  static const double width = 92;

  final PrayerModel prayer;
  final bool isNext;

  const PrayerItem({super.key, required this.prayer, required this.isNext});

  @override
  Widget build(BuildContext context) {
    Color background = isNext
        ? ColorsManger.offWhiteColor
        : ColorsManger.blackColor;
    Color foreground = isNext
        ? ColorsManger.blackColor
        : ColorsManger.offWhiteColor;

    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: isNext ? 0 : 14),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prayer.name,
            maxLines: 1,
            style: TextStyles.smallBodyTextStyle(textColor: foreground),
          ),
          const Spacer(),
          FittedBox(
            child: Text(
              prayer.formattedTime,
              style: TextStyles.mediumTitleTextStyle(textColor: foreground),
            ),
          ),
          const Spacer(),
          Text(
            prayer.period,
            style: TextStyles.smallBodyTextStyle(textColor: foreground),
          ),
        ],
      ),
    );
  }
}
