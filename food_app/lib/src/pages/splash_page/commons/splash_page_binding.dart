import 'package:food_app/src/pages/splash_page/controllers/splash_page_controller.dart';
import 'package:get/get.dart';

class SplashPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(SplashPageController.new);
  }

}