import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';

/// مستطيل بيلمع، بيتحط مكان المحتوى وهو بيتحمّل بدل الـ spinner
class ShimmerBox extends StatefulWidget {
  final double? width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    this.width,
    required this.height,
    this.radius = 16,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
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
      builder: (context, child) {
        // الشريحة اللامعة بتعدي من الشمال لليمين على طول العرض
        double slide = (controller.value * 2) - 1;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(slide - 1, 0),
              end: Alignment(slide + 1, 0),
              colors: [
                ColorsManger.goldColor.withValues(alpha: 0.10),
                ColorsManger.goldColor.withValues(alpha: 0.28),
                ColorsManger.goldColor.withValues(alpha: 0.10),
              ],
            ),
          ),
        );
      },
    );
  }
}
