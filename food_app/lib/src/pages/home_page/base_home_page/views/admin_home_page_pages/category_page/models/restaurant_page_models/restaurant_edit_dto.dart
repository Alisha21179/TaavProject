import 'package:food_app/src/infrastructure/commons/models/admin_pages_models/restaurant_view_model.dart';

import '../admin_page_base_edit_dto.dart';

class RestaurantEditDTO extends AdminPageBaseEditDTO {
  final String restaurantOwnerName, restaurantAddress;
  final List<dynamic> foodList;

  const RestaurantEditDTO({
    required this.restaurantOwnerName,
    required this.restaurantAddress,
    required this.foodList,
    required super.title,
    required super.imageBase64String,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      RestaurantViewModel.restaurantNameKey: title,
      RestaurantViewModel.restaurantOwnerNameKey: restaurantOwnerName,
      RestaurantViewModel.restaurantAddressKey: restaurantAddress,
      RestaurantViewModel.restaurantBase64ImageKey: imageBase64String,
      RestaurantViewModel.restaurantFoodListKey: foodList,
    };
  }
}
