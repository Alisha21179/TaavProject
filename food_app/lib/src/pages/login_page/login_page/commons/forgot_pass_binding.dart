import 'package:food_app/src/pages/login_page/login_page/controllers/forgot_pass_controller.dart';
import 'package:get/get.dart';

class ForgotPassBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(ForgotPassController.new);
  }
}