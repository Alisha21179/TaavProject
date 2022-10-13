import 'admin_pages_view_models.dart';

class FoodViewModel extends AdminPagesItemViewModel {
  static const String idKey = 'id';
  static const String foodNameKey = 'food_name';
  static const String foodIngredientKey = 'food_ingredients';

  final int id;
  final String foodName,foodIngredient;

  FoodViewModel({
    required this.id,
    required this.foodName,
    required this.foodIngredient,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodName': foodName,
      'foodIngredient': foodIngredient,
    };
  }

  factory FoodViewModel.fromJson(Map<String, dynamic> json) {
    return FoodViewModel(
      id: json[FoodViewModel.idKey],
      foodName: json[FoodViewModel.foodNameKey],
      foodIngredient: json[FoodViewModel.foodIngredientKey],
    );
  }
}
