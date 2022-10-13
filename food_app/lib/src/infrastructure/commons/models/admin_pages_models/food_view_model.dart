import 'admin_pages_view_models.dart';

class FoodViewModel extends AdminPagesItemViewModel {
  static const String idKey = 'id';
  static const String foodNameKey = 'title';
  static const String foodIngredientKey = 'food_ingredients';
  static const String foodBase64ImageKey = 'food_base64_image';

  final String foodIngredient;

  FoodViewModel({
    required int id,
    required String foodName,
    String? foodBase64Image,
    required this.foodIngredient,
  }) : super(
          title: foodName,
          id: id,
          imageBase64String: foodBase64Image,
        );

  factory FoodViewModel.fromJson({required Map<String, dynamic> json}) {
    return FoodViewModel(
      id: json[FoodViewModel.idKey],
      foodName: json[FoodViewModel.foodNameKey],
      foodIngredient: json[FoodViewModel.foodIngredientKey],
      foodBase64Image: json[FoodViewModel.foodBase64ImageKey],
    );
  }
}
