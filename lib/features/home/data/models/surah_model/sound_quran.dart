import 'package:equatable/equatable.dart';

import 'array.dart';

class SoundQuran extends Equatable {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? nameTranslation;
  final int? words;
  final int? letters;
  final String? type;
  final String? typeEn;
  final String? ar;
  final String? en;
  final List<Array>? array;

  const SoundQuran({
    this.id,
    this.name,
    this.nameEn,
    this.nameTranslation,
    this.words,
    this.letters,
    this.type,
    this.typeEn,
    this.ar,
    this.en,
    this.array,
  });

  factory SoundQuran.fromJson(Map<String, dynamic> json) => SoundQuran(
        id: json['id'] as int?,
        name: json['name'] as String?,
        nameEn: json['name_en'] as String?,
        nameTranslation: json['name_translation'] as String?,
        words: json['words'] as int?,
        letters: json['letters'] as int?,
        type: json['type'] as String?,
        typeEn: json['type_en'] as String?,
        ar: json['ar'] as String?,
        en: json['en'] as String?,
        array: (json['array'] as List<dynamic>?)
            ?.map((e) => Array.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_en': nameEn,
        'name_translation': nameTranslation,
        'words': words,
        'letters': letters,
        'type': type,
        'type_en': typeEn,
        'ar': ar,
        'en': en,
        'array': array?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      nameEn,
      nameTranslation,
      words,
      letters,
      type,
      typeEn,
      ar,
      en,
      array,
    ];
  }
}
