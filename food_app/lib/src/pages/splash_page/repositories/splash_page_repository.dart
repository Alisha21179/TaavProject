import 'package:dio/dio.dart';
import 'package:food_app/src/infrastructure/commons/repositories/repository_commons.dart';
import 'package:food_app/src/infrastructure/commons/url_commons.dart';
import 'package:food_app/src/pages/splash_page/models/admin_availability_model.dart';
import 'package:dartz/dartz.dart';

class SplashPageRepository {
  Dio dio = RepositoryCommons.dio;

  Future<Either<String,bool>> getAdmin() async {
    try {
      final Response<List<dynamic>> result = await dio.get(
        UrlCommons.userPath,
        queryParameters: AdminAvailabilityModel().toJson(),
      );
      return Right(result.data!.isNotEmpty);
    } on Exception catch(e) {
      return Left(e.toString());
    }
  }
}
