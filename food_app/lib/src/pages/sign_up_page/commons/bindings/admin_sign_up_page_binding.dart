import 'package:get/get.dart';

import '../../controllers/admin_sign_up_page_controller.dart';

class AdminSignupPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminSignUpPageController.new,);
  }
}
