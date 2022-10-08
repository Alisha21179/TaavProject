import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/src/pages/login_page/login_page/models/find_user_dto.dart';

import '../../../../infrastructure/commons/models/user_view_model.dart';
import '../../../../infrastructure/commons/repositories/repository_commons.dart';
import '../../../../infrastructure/commons/url_commons.dart';

class LoginPageRepository {
  Dio dio = RepositoryCommons.dio;

  Future<Either<String, UserViewModel?>> findUser(
      {required FindUserDTO findUserDTO}) async {
    UserViewModel? foundUser;

    try {
      Response<List<dynamic>> response = await dio.get<List<dynamic>>(
        UrlCommons.userPath,
        queryParameters: findUserDTO.toJson(),
      );
      if (response.data != null && response.data!.isNotEmpty) {
        foundUser = UserViewModel.fromJson(
          response.data!.first,
        );
      } else {
        foundUser = null;
      }
      return Right(foundUser);
    } on Exception catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

// Future<Either<String,>>
}
