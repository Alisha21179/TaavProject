import '../../../../../../../../infrastructure/commons/models/admin_pages_models/restaurant_view_model.dart';
import '../admin_page_base_insert_dto.dart';

class RestaurantInsertDTO extends AdminPageBaseInsertDTO{
  String restaurantAddress, restaurantOwnerName;
  String? restaurantBase64Image;
  List<Map<String, dynamic>> restaurantFoodList;

  RestaurantInsertDTO({
    required super.title,
    required this.restaurantAddress,
    required this.restaurantOwnerName,
    required this.restaurantFoodList,
    this.restaurantBase64Image,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      RestaurantViewModel.restaurantNameKey: title,
      RestaurantViewModel.restaurantAddressKey: restaurantAddress,
      RestaurantViewModel.restaurantOwnerNameKey: restaurantOwnerName,
      RestaurantViewModel.restaurantBase64ImageKey: restaurantBase64Image,
      RestaurantViewModel.restaurantFoodListKey: restaurantFoodList,
    };
  }
}
