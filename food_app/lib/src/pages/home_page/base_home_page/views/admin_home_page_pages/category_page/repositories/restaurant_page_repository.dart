import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/restaurant_view_model.dart';
import '../../../../../../../infrastructure/commons/url_commons.dart';
import 'admin_page_base_repository.dart';

class RestaurantPageRepository extends AdminPagesBaseRepository {

  @override
  final String path = UrlCommons.restaurantPath;

  @override
  Future<Either<String, List<AdminPagesItemViewModel>>>
      getItemList<T extends AdminPagesItemViewModel>() async {
    List<RestaurantViewModel> itemList = [];
    try {
      Response<List<dynamic>> response = await dio.get(path);
      if (response.data != null) {
        itemList.addAll(
          response.data!
              .map(
                (e) => RestaurantViewModel.fromJson(json: e),
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
