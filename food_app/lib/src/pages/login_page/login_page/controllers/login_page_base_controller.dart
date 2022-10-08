import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../infrastructure/commons/models/user_view_model.dart';
import '../../../../infrastructure/routes/food_app_module_page_routes.dart';
import '../repositories/login_page_repository.dart';

abstract class LoginPageBaseController extends GetxController {
  GlobalKey<FormState> mainFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController secondTextFieldController = TextEditingController();
  abstract RxBool passwordIsObSecure;
  RxBool showIndicator = false.obs;
  RxBool rememberMeCheckBoxValue = false.obs;
  final LoginPageRepository repository = LoginPageRepository();
  UserViewModel? foundUser;
  String? validatorsMessage;
  abstract final String titleText;
  abstract final String secondTextFormFieldLabel;
  abstract final String submitButtonLabel;
  abstract final bool showRememberMeCheckBox;
  abstract final bool showForgotPassword;
  abstract final bool showSignup;
  abstract final bool secondTextFormFieldIsObSecure;
  GetStorage box = GetStorage();


  Future<void> submitButtonOnPressed();

  String? usernameValidator(String? value) => validatorsMessage;

  String? passwordValidator(String? value) => validatorsMessage;

  void forgotPassword() {
    Get.toNamed(FoodAppPageRoutes.forgotPassPage);
  }

  void signUp() {
    Get.toNamed(FoodAppPageRoutes.userSignupPage);
  }

  void checkBoxOnTap(bool? value) {
    rememberMeCheckBoxValue.value = value!;
  }
}
