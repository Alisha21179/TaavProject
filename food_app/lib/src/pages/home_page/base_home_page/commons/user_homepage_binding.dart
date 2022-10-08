import 'package:get/get.dart';

import '../controllers/homepage_user_controller.dart';

class UserHomePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(UserHomePageController.new);
  }

}