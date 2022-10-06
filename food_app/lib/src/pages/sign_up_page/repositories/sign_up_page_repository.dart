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
      final Response<List<dynamic>> result = await dio.get<List<dynamic>>(
        UrlCommons.userPath,
      );
      if (result.data != null) {
        for (final json in result.data!) {
          userList.add(UserViewModel.fromJson(json));
        }
      }
      return Right(userList);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserViewModel>> signItUpToServer(
      UserViewModel user) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.post(UrlCommons.userPath, data: user.toJson());
      return Right(UserViewModel.fromJson(response.data!));
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
