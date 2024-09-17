import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_qpp/core/helper/extension.dart';
import 'package:quran_qpp/core/helper/widget/custom_textformfield.dart';
import 'package:quran_qpp/features/surah/presentation/widgets/verse%20.dart';

import '../../../../config/style/app_colors.dart';
import '../../../../config/style/app_font.dart';
import '../../../../core/app_images.dart';
import '../../../../core/helper/widget/custom_divider.dart';
import '../../../home/data/models/surah_model/sound_quran.dart';

class SurahView extends StatefulWidget {
  final SoundQuran surahs;
  const SurahView({super.key, required this.surahs});

  @override
  _SurahViewState createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  late AudioPlayer audioPlayer;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  bool isSearch = false;

  TextEditingController searchController = TextEditingController();
  var filteredAyahs = [];

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    // Initialize audio player listeners
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

    filteredAyahs = widget.surahs.array!;
  }

  // Function to play or pause audio
  Future<void> playAudio(int surahNumber) async {
    String surah = surahNumber.toString().padLeft(3, '0');
    String audioUrl = 'https://server6.mp3quran.net/qtm/$surah.mp3';

    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(UrlSource(audioUrl));
    }
  }

  // Filter ayahs based on search query
  void _filterAyahs(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredAyahs = widget.surahs.array!;
      });
    } else {
      setState(() {
        filteredAyahs = widget.surahs.array!
            .where((ayah) => ayah.en!
                .toLowerCase()
                .contains(query)) // Filter based on ayah content
            .toList();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft,
              color: AppColors.lightGray),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.surahs.nameTranslation.toString(),
          style: AppFont.font20BoldcolorWhite(context),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.search,
                color: AppColors.lightGray),
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Visibility(
              visible: isSearch,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomTextFormFeild(
                  controller: searchController,
                  label: 'Search Ayah...',
                  onCahange: _filterAyahs, // Update list on search input
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Column(children: [
                  SvgPicture.asset(
                    AppImages.card,
                    width: MediaQuery.of(context).size.width,
                  ),
                ]),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Text(
                            widget.surahs.nameTranslation.toString(),
                            style: AppFont.font24SemiBoldcolorWhite(context),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.surahs.nameEn ?? '',
                            style: AppFont.font18RegularcolorLightGray(context)
                                .copyWith(color: Colors.white),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: CustomDivider(),
                          ),
                          Text(
                            '${widget.surahs.typeEn} • ${widget.surahs.array!.length} Verses',
                            style: AppFont.font14MediumcolorWhite(context),
                          ),
                          const SizedBox(height: 15),
                          if (widget.surahs.id != 9)
                            SvgPicture.asset(AppImages.besm_allah),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 40,
                  right: 30,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => playAudio(widget.surahs.id!),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primaryColor,
                        child: isPlaying
                            ? const Icon(Icons.pause, color: Color(0xffA44AFF))
                            : SvgPicture.asset(
                                AppImages.play,
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
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
          ),
          SliverList.separated(
            itemBuilder: (context, index) => VerseWidget(
              surahName: widget.surahs.name ?? '',
              verse: filteredAyahs[index], // Display filtered ayahs
              surahNumber: widget.surahs.id!,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: filteredAyahs.length, // Update count to filtered ayahs
          ),
        ],
      ),
    );
  }
}
