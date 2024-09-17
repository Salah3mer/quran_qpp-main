import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/core/app_images.dart';
import 'package:quran_qpp/core/helper/widget/custom_divider.dart';
import 'package:quran_qpp/features/home/data/models/surah_model/array.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class VerseWidget extends StatefulWidget {
  const VerseWidget({
    super.key,
    required this.verse,
    required this.surahNumber,
    required this.surahName,
  });

  final int surahNumber;
  final String surahName;
  final Array verse;

  @override
  State<VerseWidget> createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {
  late AudioPlayer audioPlayer;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  Future<void> playAudio(int surahNumber, int ayahNumber) async {
    String surah = surahNumber.toString().padLeft(3, '0');
    String ayah = ayahNumber.toString().padLeft(3, '0');
    String audioUrl =
        'https://www.everyayah.com/data/Nasser_Alqatami_128kbps/$surah$ayah.mp3';

    if (isPlaying) {
      audioPlayer.pause();
    } else {
      try {
        await audioPlayer.play(UrlSource(audioUrl));
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> shareScreenshot() async {
    try {
      final screenshot = await screenshotController.captureFromWidget(
        Stack(
          children: [
            Image.asset(AppImages.shareFrame),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '꧁༺',
                          style: TextStyle(
                            color: const Color(0xffd4b166).withOpacity(.6),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.surahName,
                            style: AppFont.fontHafs20BoldColorWhite(context),
                          ),
                        ),
                        Text(
                          ' ༻꧂',
                          style: TextStyle(
                            color: const Color(0xffd4b166).withOpacity(.6),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 37.0),
                        child: Text(
                          widget.verse.ar!,
                          style: AppFont.fontHafs16BoldColorWhite(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          AppImages.sorahIcon,
                          fit: BoxFit.cover,
                          color: const Color(0xffd4b166).withOpacity(.6),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.verse.id.toString(),
                              style: AppFont.font18SemiBoldcolorWhite(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(screenshot);

      await Share.shareXFiles([XFile(file.path)], text: 'آية من القرآن الكريم');
    } catch (e) {
      print("Error capturing and sharing screenshot: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Screenshot(
        controller: screenshotController,
        child: Column(
          children: [
            Container(
              height: 47,
              decoration: BoxDecoration(
                color: const Color(0xff121931),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xffA44AFF),
                      child: Text(
                        widget.verse.id.toString(),
                        style: AppFont.font14MediumcolorWhite(context),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: shareScreenshot,
                      icon: SvgPicture.asset(
                        AppImages.share,
                        color: const Color(0xffA44AFF),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        playAudio(widget.surahNumber, widget.verse.id!);
                      },
                      icon: isPlaying
                          ? const Icon(
                              Icons.pause,
                              color: Color(0xffA44AFF),
                            )
                          : SvgPicture.asset(
                              AppImages.play,
                              color: const Color(0xffA44AFF),
                            ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        height: 20,
                        AppImages.bookMark,
                        color: const Color(0xffA44AFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                widget.verse.ar!,
                style: AppFont.fontHafs20BoldColorWhite(context),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.verse.en!,
                style: AppFont.font18RegularcolorLightGray(context),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 5),
            Visibility(
              visible: isPlaying,
              child: Slider(
                activeColor: const Color(0xffA44AFF),
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
            ),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }
}
