import '../../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import '../admin_page_base_insert_dto.dart';

class CategoryInsertDTO extends AdminPageBaseInsertDTO {
  final String? imageBase64String;
  final List<Map<String, dynamic>> foodList;

  const CategoryInsertDTO({
    required this.foodList,
    required super.title,
    this.imageBase64String,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      CategoryViewModel.titleKey: title,
      CategoryViewModel.imageBase64StringKey: imageBase64String,
      CategoryViewModel.foodListKey: foodList,
    };
  }
}
