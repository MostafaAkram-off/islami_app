import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/routes_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/hadeth_model.dart';

class HadethItem extends StatefulWidget {
  bool isSelected;
  int hadethNumber;

  HadethItem({super.key, required this.isSelected, required this.hadethNumber});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  @override
  Widget build(BuildContext context) {
    if (myHadeth == null) {
      readFile();
    }
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RoutesManger.hadethDetailsRouteName,arguments: myHadeth);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 8,
          right: 8,
          top: widget.isSelected ? 0 : 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorsManger.goldColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AssetsManger.leftCorner),
                      Image.asset(AssetsManger.rightCorner),
                    ],
                  ),
                  Text(
                    myHadeth?.title ?? "",
                    style: TextStyles.largeTitleTextStyle(
                      textColor: ColorsManger.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.asset(
                          AssetsManger.hadithCardBackGround,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          AssetsManger.hadethMosque,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Text(
                      myHadeth?.content ?? "",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.mediumLabelTextStyle(
                        textColor: ColorsManger.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  HadethModel? myHadeth;

  Future<void> readFile() async {
    String allHadeth = await rootBundle.loadString(
      "assets/Hadeeth/h${widget.hadethNumber}.txt",
    );
    List<String> hadethLines = allHadeth.split('\n');
    String title = hadethLines[0];
    hadethLines.removeAt(0);
    String content = hadethLines.join(" ");
    setState(() {
      myHadeth = HadethModel(
        title: title,
        content: content,
        number: widget.hadethNumber,
      );
    });
  }
}
