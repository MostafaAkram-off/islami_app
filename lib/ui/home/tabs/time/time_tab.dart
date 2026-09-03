import 'package:flutter/material.dart';
import 'package:islami_app/core/api/api_manager.dart';
import 'package:islami_app/core/reuseable_components/shimmer_box.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/routes_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/azkar_model.dart';
import 'package:islami_app/model/zekr_model.dart';
import 'package:islami_app/model/pray_time_model.dart';
import 'package:islami_app/ui/azkar/screen/azkar_screen.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/azkar_item.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/pray_time_card.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  late Future<PrayTimeModel> prayTimesFuture;

  @override
  void initState() {
    super.initState();
    loadPrayTimes();
  }

  void loadPrayTimes() {
    prayTimesFuture = ApiManager.getPrayTimes();
  }

  void openAzkar(String title, List<ZekrModel> azkar) {
    Navigator.pushNamed(
      context,
      RoutesManger.azkarRouteName,
      arguments: AzkarArguments(title: title, azkar: azkar),
    );
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
                    return const ShimmerBox(height: 270, radius: 24);
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
                      children: [
                        Expanded(
                          child: AzkarItem(
                            title: StringsManger.eveningAzkar,
                            image: AssetsManger.eveningAzkar,
                            onTap: () => openAzkar(
                              StringsManger.eveningAzkar,
                              AzkarModel.evening,
                            ),
                          ),
                        ),
                        Expanded(
                          child: AzkarItem(
                            title: StringsManger.morningAzkar,
                            image: AssetsManger.morningAzkar,
                            onTap: () => openAzkar(
                              StringsManger.morningAzkar,
                              AzkarModel.morning,
                            ),
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
          child: const Text(StringsManger.tryAgain),
        ),
      ],
    );
  }
}
