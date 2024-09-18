import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/core/helper/widget/custom_divider.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';
import 'package:quran_qpp/features/home/presentation/widgets/quran_widgets/surah_item.dart';
import 'package:quran_qpp/features/surah/presentation/widgets/verse%20.dart';

class HizbListView extends StatelessWidget {
  const HizbListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var surahList = BlocProvider.of<HomeCubit>(context).surah!.soundQuran;

        return ListView.separated(
          itemBuilder: (context, index) {
            return ExpansionTile(
                onExpansionChanged: (value) =>
                    HomeCubit.get(context).featchHizb(hizbNumber: index + 1),
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                collapsedIconColor: AppColors.lightGray,
                title: Row(
                  children: [
                    Text(
                      'الربع  ${index + 1}',
                      style: AppFont.fontHafs20BoldColorWhite(context),
                    ),
                  ],
                ),
                children: state is FeatchHizbSuccessState
                    ? List.generate(state.hizb.verses!.length, (verindex) {
                        return Column(children: [
                          if (state.hizb.verses![verindex].verseNumber == 1)
                            SurahItem(
                                surah: surahList![int.parse(state
                                        .hizb.verses![verindex].verseKey!
                                        .split(':')
                                        .first) -
                                    1]),
                          VerseWidget(
                            verse: surahList![int.parse(state
                                            .hizb.verses![verindex].verseKey!
                                            .split(':')
                                            .first) -
                                        1]
                                    .array![
                                state.hizb.verses![verindex].verseNumber! - 1],
                            surahName: surahList[int.parse(state
                                        .hizb.verses![verindex].verseKey!
                                        .split(':')
                                        .first) -
                                    1]
                                .name!,
                            surahNumber: surahList[int.parse(state
                                        .hizb.verses![verindex].verseKey!
                                        .split(':')
                                        .first) -
                                    1]
                                .id!,
                          )
                        ]);
                      })
                    : List.generate(
                        1,
                        (index) => const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )));
          },
          separatorBuilder: (context, index) => const CustomDivider(),
          itemCount: 240,
        );
      },
    );
  }
}
