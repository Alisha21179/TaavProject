import 'package:get/get.dart';

import '../controllers/sign_up_page_base_controller.dart';

class SignupPageBinding extends Bindings {
  SignUpPageBaseController controller;
  SignupPageBinding({required this.controller});
  @override
  void dependencies() {
    Get.lazyPut(() => controller);
  }
}
