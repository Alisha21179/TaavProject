import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/admin_page_base_insert_dto.dart';

import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/repositories/repository_commons.dart';
import '../models/admin_page_base_edit_dto.dart';

abstract class AdminPagesBaseRepository {
  final Dio dio = RepositoryCommons.dio;
  abstract final String path;

  Future<Either<String, List<AdminPagesItemViewModel>>>
      getItemList<T extends AdminPagesItemViewModel>();

  Future<Either<String, bool>> createNewItem<T extends AdminPageBaseInsertDTO>(
      {required T insertDTO}) async {
    bool addedSuccessFully = false;
    try {
      Response response = await dio.post(
        path,
        data: insertDTO.toJson(),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        addedSuccessFully = true;
      }
      return Right(addedSuccessFully);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteAdminPageItemFromServer(int itemId) async {
    bool deletionWasSuccessFull = false;
    try {
      Response response = await dio.delete('$path/$itemId');
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 205) {
        deletionWasSuccessFull = true;
      }
      return Right(deletionWasSuccessFull);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> editAdminItemInServer<T extends AdminPageBaseEditDTO>({
    required int adminItemId,
    required T editDTO,
  }) async {
    bool editionWasSuccessFull = false;
    try {
      Response response =
          await dio.patch('$path/$adminItemId', data: editDTO.toJson());
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 205) {
        editionWasSuccessFull = true;
      }
      return Right(editionWasSuccessFull);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
