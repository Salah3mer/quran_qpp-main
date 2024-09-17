import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/features/home/data/models/surah_model/sound_quran.dart';
import 'package:quran_qpp/features/home/data/models/surah_model/surah_model.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';
import 'package:quran_qpp/features/home/presentation/view/home_view.dart';
import 'package:quran_qpp/features/search/presentation/view/search_view.dart';
import 'package:quran_qpp/features/surah/presentation/view/surah_view.dart';
import 'package:quran_qpp/features/splash/presentation/view/splash_view.dart';

class AppRouter extends Routes {
  static Route? onGenratingRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initalRoute:
        return MaterialPageRoute(builder: ((context) => const SplashView()));
      case Routes.homeView:
        return MaterialPageRoute(builder: ((context) => const HomeView()));

      case Routes.surahView:
        SoundQuran surahs = settings.arguments as SoundQuran;
        return MaterialPageRoute(
            builder: ((context) => SurahView(surahs: surahs)));
      case Routes.searchView:
        SurahModel surahs = settings.arguments as SurahModel;

        return MaterialPageRoute(
            builder: ((context) => SearchView(surah: surahs)));

      default:
        return onRouteError();
    }
  }

  static Route<dynamic> onRouteError() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text('No Route Found'),
              ),
            )));
  }
}
