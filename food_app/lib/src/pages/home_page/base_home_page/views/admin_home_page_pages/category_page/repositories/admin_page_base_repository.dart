import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import '../../../../../../../infrastructure/commons/repositories/repository_commons.dart';
import '../../../../../../../infrastructure/commons/url_commons.dart';
import '../models/category_page_models/category_insert_dto.dart';

class AdminPagesBaseRepository {
  Dio dio = RepositoryCommons.dio;

  Future<Either<String, List<CategoryViewModel>>> getCategoryList<T extends AdminPagesItemViewModel>() async {
    List<CategoryViewModel> itemList = [];
    try {
      Response<List<dynamic>> response = await dio.get(UrlCommons.categoryPath);
      if (response.data != null) {
        itemList.addAll(
          response.data!
              .map(
                (e) => CategoryViewModel.fromJson(json: e),
              )
              .toList(),
        );
      }
      return Right(itemList);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> createNewCategory(
      {required CategoryInsertDTO insertDTO}) async {
    bool addedSuccessFully = false;
    try {
      Response response = await dio.post(
        UrlCommons.categoryPath,
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

  Future<Either<String, bool>> deleteCategoryFromServer(int categoryId) async {
    bool deletionWasSuccessFull = false;
    try {
      Response response =
          await dio.delete('${UrlCommons.categoryPath}/$categoryId');
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
}
