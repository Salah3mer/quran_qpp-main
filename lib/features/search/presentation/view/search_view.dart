import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_qpp/config/router/routes.dart';
import 'package:quran_qpp/config/style/app_colors.dart';
import 'package:quran_qpp/core/helper/widget/custom_divider.dart';
import 'package:quran_qpp/core/helper/widget/custom_textformfield.dart';
import 'package:quran_qpp/features/home/data/models/surah_model/surah_model.dart';
import 'package:quran_qpp/features/home/presentation/cubit/home_cubit.dart';
import 'package:quran_qpp/features/home/presentation/widgets/quran_widgets/surah_item.dart';

class SearchView extends StatefulWidget {
  final SurahModel surah;
  const SearchView({super.key, required this.surah});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  var filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    filteredSurahs = widget.surah.soundQuran!;
  }

  void _filterSurahs(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredSurahs = widget.surah.soundQuran!;
      });
    } else {
      setState(() {
        filteredSurahs = widget.surah.soundQuran!
            .where((surah) =>
                surah.name!.contains(query) ||
                surah.nameTranslation!.contains(query))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // حقل البحث
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            const Color(0xff7B80AD).withOpacity(.35),
                        child: const Icon(FontAwesomeIcons.arrowLeft,
                            color: AppColors.lightGray)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextFormFeild(
                      controller: searchController,
                      label: 'Search..',
                      onCahange: _filterSurahs,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.surahView,
                        arguments: filteredSurahs[index],
                      );
                    },
                    child: SurahItem(
                      surah: filteredSurahs[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => const CustomDivider(),
                  itemCount: filteredSurahs.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
