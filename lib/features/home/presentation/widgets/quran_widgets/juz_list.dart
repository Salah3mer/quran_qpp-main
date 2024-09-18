import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/core/helper/extension.dart';
import 'package:quran_qpp/core/helper/widget/custom_divider.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';
import 'package:quran_qpp/features/home/presentation/widgets/quran_widgets/surah_item.dart';

class JuzListView extends StatelessWidget {
  const JuzListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var juzList = BlocProvider.of<HomeCubit>(context).juzList;
        var surah = BlocProvider.of<HomeCubit>(context).surah!.soundQuran;
        return juzList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, juzIndex) {
                  var juz = juzList[juzIndex];
                  return ExpansionTile(
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    collapsedIconColor: AppColors.lightGray,
                    title: Row(
                      children: [
                        Text(
                          'الجزء ${juz.index}',
                          style: AppFont.fontHafs20BoldColorWhite(context),
                        ),
                      ],
                    ),
                    children: surah!
                        .where((element) => juz.surahIds.contains(element.id))
                        .map((surah) {
                      return GestureDetector(
                        onTap: () => context.pushNamed(Routes.surahView,
                            arguments: surah),
                        child: SurahItem(
                          surah: surah,
                        ),
                      );
                    }).toList(),
                  );
                },
                separatorBuilder: (context, index) => const CustomDivider(),
                itemCount: juzList.length,
              );
      },
    );
  }
}
