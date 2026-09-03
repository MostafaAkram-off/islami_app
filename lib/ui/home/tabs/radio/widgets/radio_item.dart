import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';

/// كارت الإذاعة أو الشيخ، بيعرض موجة صوت وهو شغال
/// وسيلويت المسجد وهو واقف
class RadioItem extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final bool isMuted;
  final VoidCallback onPlayPressed;
  final VoidCallback onMutePressed;

  const RadioItem({
    super.key,
    required this.title,
    required this.isPlaying,
    required this.isMuted,
    required this.onPlayPressed,
    required this.onMutePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorsManger.goldColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            isPlaying ? AssetsManger.soundWave : AssetsManger.radioCardMosque,
            height: 97,
            width: double.infinity,
            fit: BoxFit.cover,
            color: ColorsManger.brownColor.withValues(alpha: 0.35),
            colorBlendMode: BlendMode.srcIn,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.mediumTitleTextStyle(
                    textColor: ColorsManger.blackColor,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    IconButton(
                      onPressed: onPlayPressed,
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: ColorsManger.blackColor,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: onMutePressed,
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        color: ColorsManger.blackColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
