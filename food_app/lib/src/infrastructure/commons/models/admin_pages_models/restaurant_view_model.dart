import 'admin_pages_view_models.dart';

class RestaurantViewModel extends AdminPagesItemViewModel {
  static const String idKey = "id";
  static const String restaurantNameKey = "title";
  static const String restaurantAddressKey = "restaurant_address";
  static const String restaurantOwnerNameKey = "restaurant_owner_name";
  static const String restaurantBase64ImageKey = "restaurant_base64_image";
  static const String restaurantFoodListKey = "restaurant_food_list";

  final String restaurantAddress, restaurantOwnerName;
  List<dynamic> foodList;

  RestaurantViewModel({
    required int id,
    required String restaurantName,
    String? restaurantBase64Image,
    required this.restaurantAddress,
    required this.restaurantOwnerName,
    required this.foodList,
  }) : super(
          id: id,
          title: restaurantName,
          imageBase64String: restaurantBase64Image,
        );

  factory RestaurantViewModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantViewModel(
      id: json[RestaurantViewModel.idKey],
      restaurantName: json[RestaurantViewModel.restaurantNameKey],
      restaurantAddress: json[RestaurantViewModel.restaurantAddressKey],
      restaurantOwnerName: json[RestaurantViewModel.restaurantOwnerNameKey],
      restaurantBase64Image: json[RestaurantViewModel.restaurantBase64ImageKey],
      foodList: json[RestaurantViewModel.restaurantFoodListKey],
    );
  }
}
