import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_qpp/config/router/app_router.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/core/bloc_observer.dart';
import 'package:quran_qpp/features/home/data/repository/home_repo_impl.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepoImpl())..featchSurah(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            elevation: 0, // Remove shadow on AppBar
          ),
          scaffoldBackgroundColor: AppColors.primaryColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        onGenerateRoute: AppRouter.onGenratingRoute,
        initialRoute: Routes.initalRoute,
      ),
    );
  }
}
