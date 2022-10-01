import 'package:dio/dio.dart';
import 'package:food_app/src/infrastructure/commons/url_commons.dart';
import 'package:food_app/src/pages/splash_page/models/admin_availability_model.dart';
import 'package:dartz/dartz.dart';

class SplashPageRepository {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: UrlCommons.baseUrl,
      connectTimeout: 2000,
      sendTimeout: 2000,
      receiveTimeout: 2000,
    ),
  );

  Future<Either<String,bool>> getAdmin() async {
    try {
      final Response<List<dynamic>> result = await dio.get(
        UrlCommons.userPath,
        queryParameters: AdminAvailabilityModel().toJson(),
      );
      return Right(result.data!.isNotEmpty)/*result.data!.isNotEmpty*/;
    } on FormatException catch(e){
      return Left(e.message);
    } on Exception catch(e) {
      return Left(e.toString());
    }
  }
}
