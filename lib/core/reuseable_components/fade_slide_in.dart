import 'package:flutter/material.dart';

/// بيدخّل الويدجت بـ fade مع طلعة بسيطة لفوق.
/// [index] بيأخّر كل عنصر عن اللي قبله عشان الليست تدخل متدرجة
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration duration;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.duration = const Duration(milliseconds: 350),
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  static const Duration _stagger = Duration(milliseconds: 60);

  /// أقصى تأخير عشان آخر عناصر ليست طويلة متستناش كتير
  static const int _maxStaggeredItems = 8;

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    int steps = widget.index.clamp(0, _maxStaggeredItems);
    Future.delayed(_stagger * steps, () {
      if (mounted) controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );
    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(curve),
        child: widget.child,
      ),
    );
  }
}
