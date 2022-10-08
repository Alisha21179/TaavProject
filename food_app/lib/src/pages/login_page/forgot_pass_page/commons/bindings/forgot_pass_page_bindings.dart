import 'package:food_app/src/pages/login_page/forgot_pass_page/controllers/forgot_pass_page_controller.dart';
import 'package:get/get.dart';

class ForgotPassPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ForgotPassPageController.new);
  }

}