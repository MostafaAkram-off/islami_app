import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/zekr_model.dart';
import 'package:islami_app/ui/azkar/widgets/zekr_item.dart';

/// الوسيطات اللي بتتبعت للشاشة عن طريق الراوت
class AzkarArguments {
  final String title;
  final List<ZekrModel> azkar;

  const AzkarArguments({required this.title, required this.azkar});
}

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  /// عدد المرات اللي اتقالت لكل ذكر، الإندكس هو ترتيب الذكر في الليست
  late List<int> counters;
  late AzkarArguments arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)!.settings.arguments as AzkarArguments;
    counters = List.filled(arguments.azkar.length, 0);
  }

  int get doneCount {
    int done = 0;
    for (int i = 0; i < counters.length; i++) {
      if (counters[i] >= arguments.azkar[i].count) done++;
    }
    return done;
  }

  void countZekr(int index) {
    HapticFeedback.lightImpact();
    setState(() => counters[index]++);
  }

  void resetAll() {
    HapticFeedback.mediumImpact();
    setState(() => counters = List.filled(arguments.azkar.length, 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
        actions: [
          IconButton(
            onPressed: doneCount == 0 ? null : resetAll,
            tooltip: StringsManger.reset,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManger.timeBack),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            buildProgress(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: arguments.azkar.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) => ZekrItem(
                  zekr: arguments.azkar[index],
                  counter: counters[index],
                  onTap: () => countZekr(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress() {
    int total = arguments.azkar.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        spacing: 8,
        children: [
          Text(
            "${StringsManger.completed} $doneCount / $total",
            style: TextStyles.mediumLabelTextStyle(),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: total == 0 ? 0 : doneCount / total,
              ),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              builder: (context, value, child) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: ColorsManger.blackColor.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
