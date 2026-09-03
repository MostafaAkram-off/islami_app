import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';

class AzkarItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const AzkarItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorsManger.blackColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorsManger.goldColor, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Expanded(child: Image.asset(image, fit: BoxFit.contain)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.largeBodyTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
