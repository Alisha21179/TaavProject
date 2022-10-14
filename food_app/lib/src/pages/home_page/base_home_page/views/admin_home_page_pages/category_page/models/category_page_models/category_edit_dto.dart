import '../../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import '../admin_page_base_edit_dto.dart';

class CategoryEditDTO extends AdminPageBaseEditDTO {
  final List<dynamic> foodList;

  CategoryEditDTO({
    required this.foodList,
    required super.title,
    required super.imageBase64String,
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
