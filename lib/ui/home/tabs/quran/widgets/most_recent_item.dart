import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/routes_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/sura_model.dart';

class MostRecentItem extends StatelessWidget {
  final SuraModel sura;

  const MostRecentItem(this.sura, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManger.suraDetailsRouteName,
          arguments: sura,
        );
      },
      child: Container(
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
                    sura.suraNameEn,
                    style: TextStyles.largeLabelTextStyle(
                      textColor: ColorsManger.blackColor,
                    ),
                  ),
                  Text(
                    sura.suraNameAr,
                    style: TextStyles.largeLabelTextStyle(
                      textColor: ColorsManger.blackColor,
                    ),
                  ),
                  Text(
                    "${sura.versesNumber} Verses",
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
      ),
    );
  }
}
