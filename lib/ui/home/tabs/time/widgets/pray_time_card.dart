import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/pray_time_model.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/next_pray_countdown.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/prayer_item.dart';

/// الكارت الدهبي اللي فيه التاريخ والمواقيت والوقت الفاضل على الصلاة الجاية
class PrayTimeCard extends StatefulWidget {
  final PrayTimeModel prayTime;

  const PrayTimeCard({super.key, required this.prayTime});

  @override
  State<PrayTimeCard> createState() => _PrayTimeCardState();
}

class _PrayTimeCardState extends State<PrayTimeCard> {
  static const double itemsGap = 8;

  final ScrollController scrollController = ScrollController();
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToNextPrayer());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// بيوضع الصلاة الجاية في نص الليست الأفقية
  void scrollToNextPrayer() {
    if (!scrollController.hasClients) return;
    int index = widget.prayTime.prayers.indexOf(widget.prayTime.nextPrayer);
    if (index < 0) return;

    double itemExtent = PrayerItem.width + itemsGap;
    double offset =
        (index * itemExtent) -
        (MediaQuery.of(context).size.width - PrayerItem.width) / 2;

    scrollController.animateTo(
      offset.clamp(0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    PrayTimeModel prayTime = widget.prayTime;
    return Container(
      decoration: BoxDecoration(
        color: ColorsManger.goldColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          buildHeader(prayTime),
          SizedBox(
            height: 120,
            child: ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: prayTime.prayers.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: itemsGap),
              itemBuilder: (context, index) => PrayerItem(
                prayer: prayTime.prayers[index],
                isNext: prayTime.prayers[index] == prayTime.nextPrayer,
              ),
            ),
          ),
          buildFooter(prayTime),
        ],
      ),
    );
  }

  /// الشريط العلوي: التاريخ الميلادي والهجري على الجانبين
  /// و"Pray Time" واسم اليوم في النص نازلين شوية زي الديزاين
  Widget buildHeader(PrayTimeModel prayTime) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: ColorsManger.brownColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  prayTime.gregorianDate,
                  style: TextStyles.smallBodyTextStyle(),
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  prayTime.hijriDate,
                  textAlign: TextAlign.end,
                  style: TextStyles.smallBodyTextStyle(),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 180,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: ColorsManger.brownColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
              bottom: Radius.circular(32),
            ),
          ),
          child: Column(
            spacing: 4,
            children: [
              Text(
                StringsManger.prayTime,
                style: TextStyles.smallTitleTextStyle(
                  textColor: ColorsManger.offWhiteColor,
                ),
              ),
              Text(prayTime.weekDay, style: TextStyles.largeBodyTextStyle()),
            ],
          ),
        ),
      ],
    );
  }

  /// "Next Pray - 02:32:15" وجنبها زرار كتم الأذان
  Widget buildFooter(PrayTimeModel prayTime) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: NextPrayCountdown(
              prayTime: prayTime,
              onNextPrayerChanged: () {
                setState(scrollToNextPrayer);
              },
            ),
          ),
          IconButton(
            tooltip: isMuted ? StringsManger.unmute : StringsManger.mute,
            onPressed: () => setState(() => isMuted = !isMuted),
            icon: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              color: ColorsManger.blackColor,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
