import '../../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../admin_page_base_edit_dto.dart';

class FoodEditDTO extends AdminPageBaseEditDTO {
  String foodIngredient;

  FoodEditDTO({
    required this.foodIngredient,
    required super.title,
    required super.imageBase64String,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      FoodViewModel.foodNameKey: title,
      FoodViewModel.foodIngredientKey: foodIngredient,
      FoodViewModel.foodBase64ImageKey: imageBase64String,
    };
  }
}
