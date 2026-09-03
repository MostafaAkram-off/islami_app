import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/hadeth_model.dart';

class HadethDetailsScreen extends StatelessWidget {
  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HadethModel hadeth =
        ModalRoute.of(context)?.settings.arguments as HadethModel;
    return Scaffold(
      appBar: AppBar(title: Text("Hadith ${hadeth.number}")),
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
                  hadeth.content,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyles.suraVerseTextStyle(),
                ),
              ),
            ),
            Image.asset(AssetsManger.suraMosque),
          ],
        ),
      ),
    );
  }
}
