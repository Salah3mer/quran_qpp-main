import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/config/style/app_font.dart';
import 'package:quran_qpp/core/helper/extension.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: cubit.selectedIndex == 0
              ? AppBar(
                  leading: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.mendeley,
                        color: AppColors.lightGray),
                    onPressed: () {},
                  ),
                  title: Text(
                    'Quran App',
                    style: AppFont.font20BoldcolorWhite(context),
                  ),
                  actions: [
                    IconButton(
                        icon: const FaIcon(FontAwesomeIcons.search,
                            color: AppColors.lightGray),
                        onPressed: () {
                          context.pushNamed(Routes.searchView,
                              arguments: BlocProvider.of<HomeCubit>(context)
                                  .surah!
                                  );
                        }),
                  ],
                )
              : null,
          body: cubit.body[cubit.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.selectedIndex, // Currently selected index
            onTap: (index) => cubit.changeIndex(index),

            backgroundColor: const Color(
                0xff121931), // Background color for the bottom nav bar
            type: BottomNavigationBarType.fixed,
            elevation: 0, // Remove elevation for a flat design
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: cubit.icons.map((icon) {
              return BottomNavigationBarItem(
                  label: '',
                  icon: SvgPicture.asset(
                    icon,
                    color: cubit.selectedIndex == cubit.icons.indexOf(icon)
                        ? const Color(0xffA44AFF)
                        : const Color(
                            0xffA19CC5), // Color for the selected icon
                  ));
            }).toList(),
          ),
        );
      },
    );
  }
}
