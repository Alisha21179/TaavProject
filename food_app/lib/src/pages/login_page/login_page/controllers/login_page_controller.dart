import 'package:flutter/cupertino.dart';
import 'package:food_app/food_app.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  GlobalKey<FormState> mainFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool passwordIsObSecure = true.obs;
  RxBool showIndicator = false.obs;

  Future<void> loginButtonOnPressed() async {
    showIndicator.value = true;
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        showIndicator.value = false;
      },
    );
  }

  String? usernameValidator(String? value) {}

  void forgotPassword(){
    Get.toNamed(FoodAppPageRoutes.forgotPassPage);
  }

  void signUp(){
    Get.toNamed(FoodAppPageRoutes.userSignupPage);
  }
}
