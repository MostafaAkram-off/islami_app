import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/ui/home/tabs/hadeth/widgets/hadeth_item.dart';

class HadethTab extends StatefulWidget {
  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  PageController pageController=PageController(viewportFraction: 0.8);

  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManger.hadethBack),
          alignment: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            spacing: 55,
            children: [
              Image.asset(
                AssetsManger.imageHeader,
                height: height * 0.15,
                fit: BoxFit.fitHeight,
              ),
              Expanded(
                child: PageView.builder(
                  reverse: true,
                  onPageChanged: (index){
                    setState(() {
                      selectedIndex=index;
                    });
                  },
                  controller: pageController,
                  itemCount: 50,
                  itemBuilder: (context, index) => HadethItem(
                    isSelected: selectedIndex==index,
                    hadethNumber: index+1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
