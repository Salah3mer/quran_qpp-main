import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/core/app_images.dart';
import 'package:quran_qpp/features/home/data/models/surah_model/sound_quran.dart';

class SurahItem extends StatelessWidget {
  final SoundQuran surah;

  const SurahItem({
    super.key,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Stack(
          children: [
            SvgPicture.asset(AppImages.sorahIcon),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  surah.id.toString(),
                  style: AppFont.font18SemiBoldcolorWhite(context),
                ),
              ),
            )
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              surah.nameTranslation!,
              style: AppFont.font18SemiBoldcolorWhite(context),
            ),
            Text(
              '${surah.typeEn} • ${surah.array!.length} Verses ',
              style: AppFont.font14MediumcolorWhite(context)
                  .copyWith(color: AppColors.lightGray),
            ),
          ],
        ),
        trailing: Text(surah.name!,
            style: AppFont.fontAmiri20BoldcolorPirple(context)));
  }
}
