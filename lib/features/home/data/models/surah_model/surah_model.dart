import 'package:equatable/equatable.dart';

import 'sound_quran.dart';

class SurahModel extends Equatable {
  final List<SoundQuran>? soundQuran;

  const SurahModel({this.soundQuran});

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        soundQuran: (json['sound_quran'] as List<dynamic>?)
            ?.map((e) => SoundQuran.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'sound_quran': soundQuran?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [soundQuran];
}
