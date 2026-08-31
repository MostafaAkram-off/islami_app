import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/model/hadeth_model.dart';

import '../../../core/resources/text_styles.dart';

class HadethDetailsScreen extends StatelessWidget {
  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HadethModel hadeth =
        ModalRoute.of(context)?.settings.arguments as HadethModel;
    return Scaffold(
      backgroundColor: ColorsManger.blackColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorsManger.goldColor),
        centerTitle: true,
        title: Text("Hadith ${hadeth.number}", style: TextStyles.smallTitleTextStyle()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AssetsManger.leftCorner),

                    Image.asset(AssetsManger.rightCorner),
                  ],
                ),
                Text(hadeth.title, style: TextStyles.largeTitleTextStyle()),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                      child: Text(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        hadeth.content,
                        style: TextStyle(
                          height: 2.5,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: ColorsManger.goldColor,
                          fontFamily: "Janna",
                        ),
                      ),
                    )
            ),
            Image.asset(AssetsManger.suraMosque),
          ],
        ),
      ),
    );
  }
}
