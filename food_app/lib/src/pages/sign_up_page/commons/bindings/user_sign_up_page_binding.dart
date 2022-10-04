import 'package:get/get.dart';

import '../../controllers/user_sign_up_page_controller.dart';

class UserSignupPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserSignUpPageController.new,);
  }
}
