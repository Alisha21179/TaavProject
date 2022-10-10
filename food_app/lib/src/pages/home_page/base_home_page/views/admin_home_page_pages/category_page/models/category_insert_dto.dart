import 'package:food_app/src/infrastructure/commons/models/category_view_model.dart';

class CategoryInsertDTO {
  final String title;
  final String? imageBase64String;
  final List<Map<String, dynamic>> foodList;

  const CategoryInsertDTO({
    required this.foodList,
    required this.title,
    this.imageBase64String,
  });

  Map<String, dynamic> toJson() {
    return {
      CategoryViewModel.titleKey: title,
      CategoryViewModel.imageBase64StringKey: imageBase64String,
      CategoryViewModel.foodListKey: foodList,
    };
  }
}
