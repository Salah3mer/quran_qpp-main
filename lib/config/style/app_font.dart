import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/config/style/font_wight_helper.dart';

class AppFont {
  static TextStyle font28BoldcolorWhite(context) => GoogleFonts.poppins(
        fontSize: getResponsiveFontSize(context, fontSize: 28),
        color: Colors.white,
        fontWeight: FontWeightHelper.bold,
      );
  static TextStyle font20BoldcolorWhite(context) => GoogleFonts.poppins(
        fontSize: getResponsiveFontSize(context, fontSize: 20),
        color: Colors.white,
        fontWeight: FontWeightHelper.bold,
      );
  static TextStyle font24SemiBoldcolorWhite(context) => GoogleFonts.poppins(
        fontSize: getResponsiveFontSize(context, fontSize: 24),
        color: Colors.white,
        fontWeight: FontWeightHelper.semiBold,
      );

  static TextStyle font18RegularcolorLightGray(context) => GoogleFonts.poppins(
        fontSize: getResponsiveFontSize(context, fontSize: 18),
        color: AppColors.lightGray,
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle font18SemiBoldcolorWhite(context) => GoogleFonts.poppins(
        fontSize: getResponsiveFontSize(context, fontSize: 18),
        color: Colors.white,
        fontWeight: FontWeightHelper.semiBold,
      );
  static TextStyle font14MediumcolorWhite(context) => GoogleFonts.poppins(
        fontSize: getResponsiveFontSize(context, fontSize: 14),
        color: Colors.white,
        fontWeight: FontWeightHelper.medium,
      );

  //! Hafs
  static TextStyle fontHafs20BoldColorWhite(context) => TextStyle(
        fontFamily: 'Hafs',
        fontSize: getResponsiveFontSize(context, fontSize: 20),
        color: Colors.white,
        fontWeight: FontWeightHelper.bold,
      );

  static TextStyle fontHafs16BoldColorWhite(context) => const TextStyle(
        fontFamily: 'Hafs',
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeightHelper.medium,
      );

//? Amiri Font

  static TextStyle fontAmiri20BoldcolorPirple(context) => GoogleFonts.amiri(
        fontSize: getResponsiveFontSize(context, fontSize: 20),
        color: const Color(0xffA44AFF),
        fontWeight: FontWeightHelper.bold,
      );
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  if (width < 800) {
    return width / 550;
  } else if (width < 1200) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}
