import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/core/app_images.dart';
import 'package:quran_qpp/features/home/presentation/widgets/quran_widgets/tab_bar.dart';

class QuranWidgetView extends StatelessWidget {
  const QuranWidgetView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Asslamualaikum',
                style: AppFont.font18RegularcolorLightGray(context),
              ),
              const SizedBox(height: 4),
              Text('May Allah accept from you',
                  style: AppFont.font24SemiBoldcolorWhite(context)),
              const SizedBox(height: 20),
              Stack(
                children: [
                  SvgPicture.asset(
                    AppImages.lastRead,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.bookOpenReader,
                                color: Colors.white, size: 20),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('Last Read',
                                style: AppFont.font14MediumcolorWhite(context)),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Text(
                          'Surah Al-Baqarah',
                          style: AppFont.font18SemiBoldcolorWhite(context),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Ayah No: 1',
                          style: AppFont.font14MediumcolorWhite(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Expanded(child: TabBarWidget()),
        ],
      ),
    );
  }
}
