import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_qpp/core/app_images.dart';
import 'package:quran_qpp/features/home/data/models/hizb/hizb.dart';
import 'package:quran_qpp/features/home/data/models/hizb/verse.dart';
import 'package:quran_qpp/features/home/data/models/hizb_model.dart';
import 'package:quran_qpp/features/home/data/models/juz_model.dart';
import 'package:quran_qpp/features/home/data/models/surah_model/surah_model.dart';
import 'package:quran_qpp/features/home/data/repository/home_repo_impl.dart';
import 'package:quran_qpp/features/home/presentation/widgets/bookmark_widget_view.dart';
import 'package:quran_qpp/features/home/presentation/widgets/dowaa_widget_view.dart';
import 'package:quran_qpp/features/home/presentation/widgets/pray_widget_view.dart';
import 'package:quran_qpp/features/home/presentation/widgets/quran_widgets/quran_widget_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImpl homeRepoImpl;
  HomeCubit(this.homeRepoImpl) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  final List<String> icons = [
    AppImages.moshifIcon,
    AppImages.prayIcon,
    AppImages.dowaaIcon,
    AppImages.bookMark
  ];

  final List<Widget> body = [
    const QuranWidgetView(),
    const PrayWidgetView(),
    const DowaaWidgetView(),
    const BookmarkWidgetView()
  ];

  void changeIndex(int index) {
    emit(ChangeIndexLoadingState());
    selectedIndex = index;
    emit(ChangeIndexSuccessState());
  }

  SurahModel? surah;
  List<HizbModel> hizb = [];

  Future<void> featchSurah() async {
    try {
      emit(FeatchSurahLoadingState());
      final response = await rootBundle.loadString('assets/json/sound.json');
      final data = await json.decode(response);
      surah = SurahModel.fromJson(data);
      final hizbRespnse =
          await rootBundle.loadString('assets/json/quarters.json');
      final hizbData = await json.decode(hizbRespnse);
      hizb.addAll(List.from(hizbData).map((e) => HizbModel.fromJson(e)));
      emit(FeatchSurahSuccessState());
    } catch (e) {
      print('Error in surah $e');
      emit(FeatchSurahErrorState());
    }
  }

  List<Juz> juzList = [
    Juz(index: 1, surahIds: [1, 2]), // الفاتحة (1) إلى البقرة (141)
    Juz(index: 2, surahIds: [2]), // البقرة (142) إلى آل عمران (92)
    Juz(index: 3, surahIds: [2, 3]), // آل عمران (93) إلى النساء (23)
    Juz(index: 4, surahIds: [3, 4]), // النساء (24) إلى المائدة (81)
    Juz(index: 5, surahIds: [4]), // المائدة (82) إلى الأنعام (110)
    Juz(index: 6, surahIds: [4, 5]), // الأنعام (111) إلى الأعراف (87)
    Juz(index: 7, surahIds: [5, 6]), // الأعراف (88) إلى الأنفال (40)
    Juz(index: 8, surahIds: [6, 7]), // الأنفال (41) إلى التوبة (129)
    Juz(index: 9, surahIds: [7, 8]), // التوبة (130) إلى هود (5)
    Juz(index: 10, surahIds: [8, 9]), // هود (6) إلى يوسف (52)
    Juz(index: 11, surahIds: [9, 10, 11]), // يوسف (53) إلى إبراهيم (52)
    Juz(index: 12, surahIds: [11, 12]), // الحجر (1) إلى النحل (128)
    Juz(index: 13, surahIds: [12, 13, 14]), // الإسراء (1) إلى الكهف (110)
    Juz(index: 14, surahIds: [15, 16]), // الكهف (111) إلى مريم (98)
    Juz(index: 15, surahIds: [17, 18]), // مريم (99) إلى الطور (49)
    Juz(index: 16, surahIds: [18, 19, 20]), // النجم (1) إلى الرحمن (78)
    Juz(index: 17, surahIds: [21, 22]), // الواقعة (1) إلى الحشر (24)
    Juz(index: 18, surahIds: [23, 24, 25]), // الممتحنة (1) إلى الطلاق (12)
    Juz(index: 19, surahIds: [25, 26, 27]), // التحريم (1) إلى الملك (30)
    Juz(index: 20, surahIds: [27, 28, 29]), // القلم (1) إلى الحاقة (52)
    Juz(
        index: 21,
        surahIds: [29, 30, 31, 32, 33]), // المعارج (1) إلى النبأ (40)
    Juz(
        index: 22,
        surahIds: [33, 34, 35, 36]), // النازعات (1) إلى الانشقاق (25)
    Juz(index: 23, surahIds: [36, 37, 38, 39]), // البروج (1) إلى البلد (20)
    Juz(index: 24, surahIds: [39, 40, 41]), // الشمس (1) إلى الليل (21)
    Juz(index: 25, surahIds: [41, 42, 43, 44, 45]), // الضحى (1) إلى الفجر (30)
    Juz(
        index: 26,
        surahIds: [46, 47, 48, 49, 50, 51]), // عبس (1) إلى الليل (21)
    Juz(
        index: 27,
        surahIds: [51, 52, 53, 54, 55, 56, 57]), // النبأ (1) إلى الناس (6)
    Juz(index: 28, surahIds: [
      58,
      59,
      60,
      61,
      62,
      63,
      64,
      65,
      66
    ]), // الفتح (1) إلى المزمل (20)
    Juz(index: 29, surahIds: [
      67,
      68,
      69,
      70,
      71,
      72,
      73,
      74,
      75,
      76,
      77
    ]), // المدثر (1) إلى الناس (6)
    Juz(index: 30, surahIds: [
      78,
      79,
      80,
      81,
      82,
      83,
      84,
      85,
      86,
      87,
      88,
      89,
      90,
      91,
      92,
      93,
      94,
      95,
      96,
      97,
      98,
      99,
      100,
      101,
      102,
      103,
      104,
      105,
      106,
      107,
      108,
      109,
      110,
      111,
      112,
      113,
      114,
    ]), // النبأ (1) إلى الناس (6)
  ];

  List<Verse> verses = [];
  Future<void> featchHizb({required int hizbNumber}) async {
    emit(FeatchHizbLoadingState());

    final result = await homeRepoImpl.getHizb(hizbNumber: hizbNumber);
    result.fold((l) => emit(FeatchHizbErrorState()), (r) {
      verses = r.verses ?? [];
      emit(FeatchHizbSuccessState(hizb: r));
    });
  }
}
