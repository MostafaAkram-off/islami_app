import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami_app/core/local/prefs_manager.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/sura_model.dart';
import 'package:islami_app/ui/home/tabs/quran/widgets/sura_item.dart';

import 'widgets/most_recent_item.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  String searchText = "";
  List<SuraModel> filteredSuras = SuraModel.surasList;
  List<SuraModel> mostRecent = PrefsManager.getMostRecent();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManger.quranBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                AssetsManger.imageHeader,
                height: screenHeight * 0.18,
                width: screenWidth * 0.67,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              enabled: true,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                  search();
                });
              },
              style: TextStyles.largeBodyTextStyle(),
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsManger.blackColor.withValues(alpha: 0.7),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    AssetsManger.quranTab,
                    colorFilter: ColorFilter.mode(
                      ColorsManger.goldColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColorsManger.goldColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColorsManger.goldColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColorsManger.goldColor),
                ),
                hintText: StringsManger.suraName,
                hintStyle: TextStyles.largeBodyTextStyle(),
              ),
            ),
            SizedBox(height: 20),
            if (searchText.isEmpty && mostRecent.isNotEmpty) ...[
              Text(
                StringsManger.mostRecently,
                style: TextStyles.largeBodyTextStyle(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => MostRecentItem(mostRecent[index]),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: mostRecent.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10),
            ],
            Text(
              StringsManger.surasList,
              style: TextStyles.largeBodyTextStyle(),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    SuraItem(filteredSuras[index], () {
                      setState(() {
                        mostRecent.remove(filteredSuras[index]);
                        mostRecent.insert(0, filteredSuras[index]);
                        PrefsManager.saveMostRecent(mostRecent);
                      });
                    }),
                separatorBuilder: (context, index) =>
                    Divider(color: ColorsManger.whiteColor),
                itemCount: filteredSuras.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search() {
    if (searchText.isNotEmpty) {
      filteredSuras = SuraModel.surasList;
      filteredSuras = filteredSuras
          .where(
            (sura) =>
                sura.suraNameEn.toLowerCase().contains(
                  searchText.trim().toLowerCase(),
                ) ||
                sura.suraNameAr.contains(searchText.trim()),
          )
          .toList();
    } else {
      filteredSuras = SuraModel.surasList;
    }
  }
}
