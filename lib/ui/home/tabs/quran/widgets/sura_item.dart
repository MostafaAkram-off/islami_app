import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/routes_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/sura_model.dart';

class SuraItem extends StatelessWidget {
  SuraModel sura;

  SuraItem(this.sura);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesManger.suraDetailsRouteName,arguments: sura);
      },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(AssetsManger.suraNumber),
              Text(
                sura.suraNumber.toString(),
                style: TextStyles.smallTitleTextStyle(
                  textColor: ColorsManger.whiteColor,
                ),
              ),
            ],
          ),
          SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sura.suraNameEn,
                  style: TextStyles.smallTitleTextStyle(
                    textColor: ColorsManger.whiteColor,
                  ),
                ),
                Text(
                  "${sura.versesNumber} Verses",
                  style: TextStyles.mediumBodyTextStyle(
                    textColor: ColorsManger.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            sura.suraNameAr,
            style: TextStyles.smallTitleTextStyle(
              textColor: ColorsManger.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
