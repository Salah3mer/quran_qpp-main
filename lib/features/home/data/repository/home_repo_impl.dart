import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quran_qpp/features/home/data/models/hizb/hizb.dart';
import 'package:quran_qpp/features/home/data/repository/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<String, Hizb>> getHizb({required int hizbNumber}) async {
    try {
      final dio = Dio();

      final response = await dio
          .get('https://api.quran.com/api/v4/verses/by_rub/$hizbNumber');
      return right(Hizb.fromJson(response.data));
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }
}
