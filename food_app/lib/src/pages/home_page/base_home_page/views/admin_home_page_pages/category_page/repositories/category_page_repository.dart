import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import '../../../../../../../infrastructure/commons/url_commons.dart';
import 'admin_page_base_repository.dart';

class CategoryPageRepository extends AdminPagesBaseRepository {

  @override
  final String path = UrlCommons.categoryPath;

  @override
  Future<Either<String, List<AdminPagesItemViewModel>>>
      getItemList<T extends AdminPagesItemViewModel>() async {
    List<CategoryViewModel> categoryList = [];
    try {
      Response<List<dynamic>> response = await dio.get(path);
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
      return Left(e.toString());
    }
  }
}
