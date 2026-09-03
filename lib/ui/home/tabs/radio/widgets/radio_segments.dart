import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';

/// الاختيار بين الإذاعات والقُرّاء
enum RadioSegment { radio, reciters }

class RadioSegments extends StatelessWidget {
  final RadioSegment selected;
  final ValueChanged<RadioSegment> onChanged;

  const RadioSegments({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: ColorsManger.blackColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          buildSegment(RadioSegment.radio, StringsManger.radio),
          buildSegment(RadioSegment.reciters, StringsManger.reciters),
        ],
      ),
    );
  }

  Widget buildSegment(RadioSegment segment, String label) {
    bool isSelected = segment == selected;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(segment),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? ColorsManger.goldColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyles.mediumLabelTextStyle(
              textColor: isSelected
                  ? ColorsManger.blackColor
                  : ColorsManger.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
