import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/core/helper/widget/custom_divider.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';
import 'package:quran_qpp/features/home/presentation/widgets/surah_item.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var surah = BlocProvider.of<HomeCubit>(context).surah;
        return surah == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.surahView,
                            arguments: surah.soundQuran![index]);
                      },
                      child: SurahItem(
                        surah: surah.soundQuran![index],
                      ),
                    ),
                separatorBuilder: (context, index) => const CustomDivider(),
                itemCount: surah.soundQuran!.length);
      },
    );
  }
}

