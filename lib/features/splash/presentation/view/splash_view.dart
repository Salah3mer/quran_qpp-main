import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/config/style/font_wight_helper.dart';
import 'package:quran_qpp/core/helper/extension.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quran App',
              style: AppFont.font28BoldcolorWhite(context),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Learn Quran and\n Recite once everyday',
              textAlign: TextAlign.center,
              style: AppFont.font18RegularcolorLightGray(context),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SvgPicture.asset(
                              'assets/images/qurain_image.svg')),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    width: 185,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF9B091)),
                      onPressed: () {
                        context.pushReplacementNamed(Routes.homeView);
                      },
                      child: Text(
                        'Get Started',
                        style: AppFont.font18RegularcolorLightGray(context)
                            .copyWith(
                                color: const Color(0xff091945),
                                fontWeight: FontWeightHelper.semiBold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
