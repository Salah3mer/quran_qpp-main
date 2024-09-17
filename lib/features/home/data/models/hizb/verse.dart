import 'package:equatable/equatable.dart';

class Verse extends Equatable {
	final int? id;
	final int? verseNumber;
	final String? verseKey;
	final int? hizbNumber;
	final int? rubElHizbNumber;
	final int? rukuNumber;
	final int? manzilNumber;
	final dynamic sajdahNumber;
	final int? pageNumber;
	final int? juzNumber;

	const Verse({
		this.id, 
		this.verseNumber, 
		this.verseKey, 
		this.hizbNumber, 
		this.rubElHizbNumber, 
		this.rukuNumber, 
		this.manzilNumber, 
		this.sajdahNumber, 
		this.pageNumber, 
		this.juzNumber, 
	});

	factory Verse.fromJson(Map<String, dynamic> json) => Verse(
				id: json['id'] as int?,
				verseNumber: json['verse_number'] as int?,
				verseKey: json['verse_key'] as String?,
				hizbNumber: json['hizb_number'] as int?,
				rubElHizbNumber: json['rub_el_hizb_number'] as int?,
				rukuNumber: json['ruku_number'] as int?,
				manzilNumber: json['manzil_number'] as int?,
				sajdahNumber: json['sajdah_number'] as dynamic,
				pageNumber: json['page_number'] as int?,
				juzNumber: json['juz_number'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'verse_number': verseNumber,
				'verse_key': verseKey,
				'hizb_number': hizbNumber,
				'rub_el_hizb_number': rubElHizbNumber,
				'ruku_number': rukuNumber,
				'manzil_number': manzilNumber,
				'sajdah_number': sajdahNumber,
				'page_number': pageNumber,
				'juz_number': juzNumber,
			};

	@override
	List<Object?> get props {
		return [
				id,
				verseNumber,
				verseKey,
				hizbNumber,
				rubElHizbNumber,
				rukuNumber,
				manzilNumber,
				sajdahNumber,
				pageNumber,
				juzNumber,
		];
	}
}
