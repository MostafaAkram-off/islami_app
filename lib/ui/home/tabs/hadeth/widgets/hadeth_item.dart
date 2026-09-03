import 'package:flutter/material.dart';
import 'package:islami_app/core/local/text_assets.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/routes_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/hadeth_model.dart';

class HadethItem extends StatefulWidget {
  final bool isSelected;
  final int hadethNumber;

  const HadethItem({
    super.key,
    required this.isSelected,
    required this.hadethNumber,
  });

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  HadethModel? myHadeth;

  @override
  void initState() {
    super.initState();
    readFile();
  }

  Future<void> readFile() async {
    List<String> lines = await TextAssets.readLines(
      "assets/Hadeeth/h${widget.hadethNumber}.txt",
    );
    if (lines.isEmpty || !mounted) return;
    setState(() {
      myHadeth = HadethModel(
        title: lines.first,
        content: lines.skip(1).join(" "),
        number: widget.hadethNumber,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (myHadeth == null) return;
        Navigator.of(
          context,
        ).pushNamed(RoutesManger.hadethDetailsRouteName, arguments: myHadeth);
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
                      Image.asset(AssetsManger.hadethLeftCorner),
                      Image.asset(AssetsManger.hadethRightCorner),
                    ],
                  ),
                  Text(
                    myHadeth?.title ?? "",
                    style: TextStyles.smallTitleTextStyle(
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
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: Text(
                        myHadeth?.content ?? "",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        maxLines: 22,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.hadethCardTextStyle(),
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
}
