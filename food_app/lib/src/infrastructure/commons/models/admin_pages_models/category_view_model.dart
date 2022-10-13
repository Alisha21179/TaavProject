import 'admin_pages_view_models.dart';

class CategoryViewModel extends AdminPagesItemViewModel {
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String imageBase64StringKey = 'imageBase64String';
  static const String foodListKey = 'foodList';

  final int id;
  final String title;
  final String? imageBase64String;

  //Map<String, dynamic>
  final List<dynamic> foodList;

  CategoryViewModel({
    required this.foodList,
    required this.id,
    required this.title,
    this.imageBase64String,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'imageBase64String': imageBase64String,
  //   };
  // }

  factory CategoryViewModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryViewModel(
      id: json[CategoryViewModel.idKey],
      title: json[CategoryViewModel.titleKey],
      imageBase64String: json[CategoryViewModel.imageBase64StringKey],
      foodList: json[CategoryViewModel.foodListKey],
    );
  }
}
