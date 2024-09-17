import 'package:dartz/dartz.dart';
import 'package:quran_qpp/features/home/data/models/hizb/hizb.dart';

abstract class HomeRepo {
  Future<Either<String, Hizb>> getHizb({required int hizbNumber});
}
