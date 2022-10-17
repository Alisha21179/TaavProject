import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../../infrastructure/commons/models/user_view_model.dart';
import '../../../../../../../infrastructure/commons/repositories/repository_commons.dart';
import '../../../../../../../infrastructure/commons/url_commons.dart';

class MyProfilePageRepository{

  Future<Either<String, UserViewModel?>> getSavedUsers({
    required String username,
    required String password,
  }) async {
    Dio dio = RepositoryCommons.dio;
    UserViewModel? savedUsers;
    try {
      final Response<List<dynamic>> result = await dio.get(
        UrlCommons.userPath,
        queryParameters: {
          UserViewModel.usernameKey: username,
          UserViewModel.passwordKey: password,
        },
      );
      if (result.data != null && result.data!.isNotEmpty) {
        savedUsers = UserViewModel.fromJson(result.data!.first);
      }
      return Right(savedUsers);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}