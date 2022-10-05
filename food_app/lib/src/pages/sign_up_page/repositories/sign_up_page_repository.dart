import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/src/infrastructure/commons/models/user_view_model.dart';
import 'package:food_app/src/infrastructure/commons/repositories/repository_commons.dart';
import 'package:food_app/src/infrastructure/commons/url_commons.dart';

class SignUpPageRepository {
  final Dio dio = RepositoryCommons.dio;

  Future<Either<String, List<UserViewModel>>> getUser() async {
    final List<UserViewModel> userList = [];
    try {
      final Response<List<dynamic>> result = await dio.get(
        UrlCommons.userPath,
      );
      if (result.data != null) {
        for (Map<String,dynamic> json in result.data!) {
            userList.add(UserViewModel.fromJson(json));
          }
      }
      return Right(userList);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
