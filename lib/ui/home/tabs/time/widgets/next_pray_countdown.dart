import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/pray_time_model.dart';

/// العداد بيتحدث كل ثانية، فمعزول في ويدجت لوحده عشان الـ rebuild
/// يقع عليه هو بس مش على الكارت والليست كلها
class NextPrayCountdown extends StatefulWidget {
  final PrayTimeModel prayTime;

  /// بتتنادى لما الصلاة الجاية تتغير عشان الكارت يحدّث الصلاة المميزة
  final VoidCallback onNextPrayerChanged;

  const NextPrayCountdown({
    super.key,
    required this.prayTime,
    required this.onNextPrayerChanged,
  });

  @override
  State<NextPrayCountdown> createState() => _NextPrayCountdownState();
}

class _NextPrayCountdownState extends State<NextPrayCountdown> {
  Timer? timer;
  late PrayerModel nextPrayer = widget.prayTime.nextPrayer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => onTick());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void onTick() {
    if (!mounted) return;
    PrayerModel current = widget.prayTime.nextPrayer;
    if (current != nextPrayer) {
      nextPrayer = current;
      widget.onNextPrayerChanged();
    }
    setState(() {});
  }

  /// بيحول المدة الفاضلة لـ "02:32:15"
  String formatRemaining(Duration duration) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes % 60)}"
        ":${twoDigits(duration.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${StringsManger.nextPray} - "
      "${formatRemaining(widget.prayTime.timeToNextPrayer)}",
      textAlign: TextAlign.center,
      style: TextStyles.mediumLabelTextStyle(
        textColor: ColorsManger.blackColor,
      ),
    );
  }
}
