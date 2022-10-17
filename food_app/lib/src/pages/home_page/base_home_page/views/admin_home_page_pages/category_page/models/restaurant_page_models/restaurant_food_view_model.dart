import '../../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';

class RestaurantFoodViewModel extends FoodViewModel{
  static const String foodPriceKey = "food_price";

  final String foodPrice;

  RestaurantFoodViewModel({
    required super.foodName,
    required super.foodIngredient,
    required this.foodPrice,
    super.foodBase64Image,
  }) : super(id: 0);

  @override
  Map<String, dynamic> toJson() {
    return {
      FoodViewModel.foodNameKey: title,
      FoodViewModel.foodIngredientKey: foodIngredient,
      FoodViewModel.foodBase64ImageKey: imageBase64String,
      RestaurantFoodViewModel.foodPriceKey: foodPrice,
    };
  }

  factory RestaurantFoodViewModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantFoodViewModel(
      foodName: json[FoodViewModel.foodNameKey],
      foodIngredient: json[FoodViewModel.foodIngredientKey],
      foodPrice: json[RestaurantFoodViewModel.foodPriceKey],
      foodBase64Image: json[FoodViewModel.foodBase64ImageKey],
    );
  }

  @override
  int get id => throw 'doesn\'t have id';
}
