import 'admin_pages_view_models.dart';

class CategoryViewModel extends AdminPagesItemViewModel {
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String imageBase64StringKey = 'imageBase64String';
  static const String foodListKey = 'foodList';

  final List<dynamic> foodList;

  CategoryViewModel({
    required int id,
    required this.foodList,
    required String title,
    String? categoryImageBase64String,
  }) : super(
          id: id,
          title: title,
          imageBase64String: categoryImageBase64String,
        );

  factory CategoryViewModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryViewModel(
      id: json[CategoryViewModel.idKey],
      title: json[CategoryViewModel.titleKey],
      categoryImageBase64String: json[CategoryViewModel.imageBase64StringKey],
      foodList: json[CategoryViewModel.foodListKey],
    );
  }
}
