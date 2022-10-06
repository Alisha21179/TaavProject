import 'package:food_app/src/pages/login_page/controllers/login_page_controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginPageController.new);
  }
}