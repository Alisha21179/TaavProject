import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/src/infrastructure/commons/models/category_view_model.dart';
import 'package:food_app/src/infrastructure/commons/repositories/repository_commons.dart';
import 'package:food_app/src/infrastructure/commons/url_commons.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/category_insert_dto.dart';

class CategoryPageRepository {
  Dio dio = RepositoryCommons.dio;

  Future<Either<String, List<CategoryViewModel>>> getCategoryList() async {
    List<CategoryViewModel> categoryList = [];
    try {
      Response<List<dynamic>> response = await dio.get(UrlCommons.categoryPath);
      if (response.data != null) {
        categoryList.addAll(
          response.data!
              .map(
                (e) => CategoryViewModel.fromJson(json: e),
              )
              .toList(),
        );
      }
      return Right(categoryList);
    } on Exception catch (e) {
      print(e.toString());
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
}
