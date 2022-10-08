import 'package:get/get.dart';

import '../controllers/categories_page_controller.dart';

class CategoriesPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(CategoriesPageController.new);
  }

}