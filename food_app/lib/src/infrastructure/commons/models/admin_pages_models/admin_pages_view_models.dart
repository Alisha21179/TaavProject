import 'category_view_model.dart';
import 'food_view_model.dart';
import 'restaurant_view_model.dart';

abstract class AdminPagesItemViewModel {
  final int id;
  final String title;
  final String? imageBase64String;

  AdminPagesItemViewModel({
    required this.id,
    required this.title,
    this.imageBase64String,
  });

  // factory AdminPagesItemViewModel.categoryFromJson(Map<String, dynamic> json) {
  //   return CategoryViewModel(
  //     foodList: json[CategoryViewModel.foodListKey],
  //     id: json[CategoryViewModel.idKey],
  //     title: json[CategoryViewModel.titleKey],
  //     imageBase64String: json[CategoryViewModel.imageBase64StringKey],
  //   );
  // }
  //
  // factory AdminPagesItemViewModel.foodFromJson(Map<String, dynamic> json) {
  //   return FoodViewModel(
  //     id: json[FoodViewModel.idKey],
  //     foodName: json[FoodViewModel.foodNameKey],
  //     foodIngredient: json[FoodViewModel.foodIngredientKey],
  //     foodBase64Image: json[FoodViewModel.foodBase64ImageKey],
  //   );
  // }
  //
  // factory AdminPagesItemViewModel.restaurantFromJson(
  //     Map<String, dynamic> json) {
  //   return RestaurantViewModel(
  //     id: json[RestaurantViewModel.idKey],
  //     restaurantName: json[RestaurantViewModel.restaurantNameKey],
  //     restaurantAddress: json[RestaurantViewModel.restaurantAddressKey],
  //     restaurantOwnerName: json[RestaurantViewModel.restaurantOwnerNameKey],
  //     restaurantBase64Image: json[RestaurantViewModel.restaurantBase64ImageKey],
  //   );
  // }

}
