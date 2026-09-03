import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';

/// موجة الصوت اللي في كارت الإذاعة الشغالة.
/// الصورة بتتكرر أفقياً وبنزحلق نقطة بدايتها عشان تبان ماشية
class SoundWave extends StatefulWidget {
  final double height;

  const SoundWave({super.key, required this.height});

  @override
  State<SoundWave> createState() => _SoundWaveState();
}

class _SoundWaveState extends State<SoundWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(AssetsManger.soundWave),
            repeat: ImageRepeat.repeatX,
            fit: BoxFit.fitHeight,
            alignment: Alignment(-1 + (controller.value * 2), 0),
            colorFilter: ColorFilter.mode(
              ColorsManger.brownColor.withValues(alpha: 0.35),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
