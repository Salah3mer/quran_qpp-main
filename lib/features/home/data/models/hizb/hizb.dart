import 'package:equatable/equatable.dart';

import 'pagination.dart';
import 'verse.dart';

class Hizb extends Equatable {
	final List<Verse>? verses;
	final Pagination? pagination;

	const Hizb({this.verses, this.pagination});

	factory Hizb.fromJson(Map<String, dynamic> json) => Hizb(
				verses: (json['verses'] as List<dynamic>?)
						?.map((e) => Verse.fromJson(e as Map<String, dynamic>))
						.toList(),
				pagination: json['pagination'] == null
						? null
						: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'verses': verses?.map((e) => e.toJson()).toList(),
				'pagination': pagination?.toJson(),
			};

	@override
	List<Object?> get props => [verses, pagination];
}
