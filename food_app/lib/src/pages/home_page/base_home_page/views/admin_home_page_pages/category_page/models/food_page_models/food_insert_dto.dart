import '../../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../admin_page_base_insert_dto.dart';

class FoodInsertDTO extends AdminPageBaseInsertDTO {
  final String foodIngredient;
  final String? foodBase64Image;

  const FoodInsertDTO({
    required super.title,
    required this.foodIngredient,
    this.foodBase64Image,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      FoodViewModel.foodNameKey: title,
      FoodViewModel.foodIngredientKey: foodIngredient,
      FoodViewModel.foodBase64ImageKey: foodBase64Image,
    };
  }
}
