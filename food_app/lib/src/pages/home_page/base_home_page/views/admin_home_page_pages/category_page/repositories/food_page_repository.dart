import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/src/infrastructure/commons/models/admin_pages_models/food_view_model.dart';

import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/url_commons.dart';
import 'admin_page_base_repository.dart';

class FoodPageRepository extends AdminPagesBaseRepository {

  @override
  final String path = UrlCommons.foodPath;

  @override
  Future<Either<String, List<AdminPagesItemViewModel>>>
      getItemList<T extends AdminPagesItemViewModel>() async {
    List<FoodViewModel> itemList = [];
    try {
      Response<List<dynamic>> response = await dio.get(path);
      if (response.data != null) {
        itemList.addAll(
          response.data!
              .map(
                (e) => FoodViewModel.fromJson(json: e),
              )
              .toList(),
        );
      }
      return Right(itemList);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
