import 'package:flutter/material.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/features/home/presentation/widgets/hizb_list.dart';
import 'package:quran_qpp/features/home/presentation/widgets/juz_list.dart';
import 'package:quran_qpp/features/home/presentation/widgets/surah_list_view.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              child: TabBar(
                  isScrollable: false,
                  indicatorColor: const Color(0xffA44AFF),
                  automaticIndicatorColorAdjustment: true,
                  dividerHeight: 0,
                  indicatorWeight: 3.0, // Thickness of the indicator
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: AppFont.font18SemiBoldcolorWhite(context),
                  unselectedLabelStyle:
                      AppFont.font18RegularcolorLightGray(context),
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 20),
                  onTap: (value) {
                    switch (value) {
                      case 0:
                      case 1:
                      case 2:
                      case 3:
                    }
                  },
                  tabs: const [
                    Tab(child: Text('Surah')),
                    Tab(child: Text('Juz')),
                    Tab(child: Text('Hizb')),
                    Tab(child: Text('Hijri')),
                  ]),
            ),
            const Expanded(
              child: TabBarView(children: [
                SurahListView(),
                JuzListView(),
                HizbListView(),
                Center(child: Text('Hijri Content')),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
