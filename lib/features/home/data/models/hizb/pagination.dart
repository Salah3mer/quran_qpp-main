import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
	final int? perPage;
	final int? currentPage;
	final dynamic nextPage;
	final int? totalPages;
	final int? totalRecords;

	const Pagination({
		this.perPage, 
		this.currentPage, 
		this.nextPage, 
		this.totalPages, 
		this.totalRecords, 
	});

	factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
				perPage: json['per_page'] as int?,
				currentPage: json['current_page'] as int?,
				nextPage: json['next_page'] as dynamic,
				totalPages: json['total_pages'] as int?,
				totalRecords: json['total_records'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'per_page': perPage,
				'current_page': currentPage,
				'next_page': nextPage,
				'total_pages': totalPages,
				'total_records': totalRecords,
			};

	@override
	List<Object?> get props {
		return [
				perPage,
				currentPage,
				nextPage,
				totalPages,
				totalRecords,
		];
	}
}
