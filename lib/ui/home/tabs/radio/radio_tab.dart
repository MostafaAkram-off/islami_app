import 'package:flutter/material.dart';
import 'package:islami_app/core/api/api_manager.dart';
import 'package:islami_app/core/resources/assets_manger.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/strings_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';
import 'package:islami_app/model/radio_model.dart';
import 'package:islami_app/model/reciter_model.dart';
import 'package:islami_app/ui/home/tabs/radio/widgets/radio_item.dart';
import 'package:islami_app/ui/home/tabs/radio/widgets/radio_segments.dart';
import 'package:just_audio/just_audio.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  final AudioPlayer player = AudioPlayer();

  RadioSegment selectedSegment = RadioSegment.radio;
  late Future<List<RadioModel>> radiosFuture;
  late Future<List<ReciterModel>> recitersFuture;

  /// اللينك اللي شغال دلوقتي، بيتقارن بيه الكارت عشان يعرف هو الشغال ولا لأ
  String? playingUrl;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    radiosFuture = ApiManager.getRadios();
    recitersFuture = ApiManager.getReciters();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  /// لو الكارت المضغوط هو الشغال بيوقف، وغير كده بيشغل اللينك الجديد
  Future<void> togglePlay(String? url) async {
    if (url == null) return;

    if (playingUrl == url) {
      await player.stop();
      setState(() => playingUrl = null);
      return;
    }

    setState(() => playingUrl = url);
    try {
      await player.setUrl(url);
      await player.play();
    } catch (_) {
      if (mounted) setState(() => playingUrl = null);
    }
  }

  void toggleMute() {
    setState(() => isMuted = !isMuted);
    player.setVolume(isMuted ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManger.radioBack),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            children: [
              Image.asset(
                AssetsManger.imageHeader,
                height: screenHeight * 0.15,
                fit: BoxFit.fitHeight,
              ),
              RadioSegments(
                selected: selectedSegment,
                onChanged: (segment) =>
                    setState(() => selectedSegment = segment),
              ),
              Expanded(
                child: selectedSegment == RadioSegment.radio
                    ? buildRadios()
                    : buildReciters(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadios() {
    return buildList<RadioModel>(
      future: radiosFuture,
      onRetry: () => radiosFuture = ApiManager.getRadios(),
      itemBuilder: (radio) => RadioItem(
        title: radio.name,
        isPlaying: playingUrl == radio.url,
        isMuted: isMuted,
        onPlayPressed: () => togglePlay(radio.url),
        onMutePressed: toggleMute,
      ),
    );
  }

  Widget buildReciters() {
    return buildList<ReciterModel>(
      future: recitersFuture,
      onRetry: () => recitersFuture = ApiManager.getReciters(),
      itemBuilder: (reciter) => RadioItem(
        title: reciter.name,
        isPlaying: playingUrl == reciter.firstSurahUrl,
        isMuted: isMuted,
        onPlayPressed: () => togglePlay(reciter.firstSurahUrl),
        onMutePressed: toggleMute,
      ),
    );
  }

  Widget buildList<T>({
    required Future<List<T>> future,
    required VoidCallback onRetry,
    required Widget Function(T item) itemBuilder,
  }) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) return buildError(onRetry);
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: ColorsManger.goldColor),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: snapshot.data!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) => itemBuilder(snapshot.data![index]),
        );
      },
    );
  }

  Widget buildError(VoidCallback onRetry) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          StringsManger.somethingWentWrong,
          style: TextStyles.largeBodyTextStyle(),
        ),
        ElevatedButton(
          onPressed: () => setState(onRetry),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManger.goldColor,
            foregroundColor: ColorsManger.blackColor,
          ),
          child: const Text(StringsManger.tryAgain),
        ),
      ],
    );
  }
}
