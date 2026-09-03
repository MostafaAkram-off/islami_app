import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami_app/core/api/api_manager.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/pray_time_model.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/azkar_item.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/pray_time_card.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  late Future<PrayTimeModel> prayTimesFuture;

  /// بيعمل rebuild كل ثانية عشان العداد بتاع الصلاة الجاية ينزل
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    loadPrayTimes();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void loadPrayTimes() {
    prayTimesFuture = ApiManager.getPrayTimes();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManger.timeBack),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AssetsManger.imageHeader,
                  height: screenHeight * 0.15,
                  fit: BoxFit.fitHeight,
                ),
              ),
              FutureBuilder<PrayTimeModel>(
                future: prayTimesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return buildError();
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManger.goldColor,
                      ),
                    );
                  }
                  return PrayTimeCard(prayTime: snapshot.data!);
                },
              ),
              Text(
                StringsManger.azkarTitle,
                style: TextStyles.largeBodyTextStyle(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: screenHeight * 0.28,
                    child: Row(
                      spacing: 16,
                      children: const [
                        Expanded(
                          child: AzkarItem(
                            title: StringsManger.eveningAzkar,
                            image: AssetsManger.eveningAzkar,
                          ),
                        ),
                        Expanded(
                          child: AzkarItem(
                            title: StringsManger.morningAzkar,
                            image: AssetsManger.morningAzkar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildError() {
    return Column(
      spacing: 8,
      children: [
        Text(
          StringsManger.somethingWentWrong,
          style: TextStyles.largeBodyTextStyle(),
        ),
        ElevatedButton(
          onPressed: () => setState(loadPrayTimes),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManger.goldColor,
            foregroundColor: ColorsManger.blackColor,
          ),
          child: const Text(StringsManger.tryAgain),
        ),
      ],
    );
  }
}
