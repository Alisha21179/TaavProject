import 'package:get/get.dart';

import '../controllers/login_page_login_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginPageController.new);
  }
}