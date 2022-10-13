import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/commons/models/user_view_model.dart';
import '../../../../infrastructure/routes/food_app_module_page_routes.dart';
import '../models/find_user_dto.dart';
import 'login_page_base_controller.dart';

class LoginPageController extends LoginPageBaseController {
  @override
  RxBool passwordIsObSecure = true.obs;

  @override
  final bool showForgotPassword = true;

  @override
  final bool showRememberMeCheckBox = true;

  @override
  final bool showSignup = true;

  @override
  final bool secondTextFormFieldIsObSecure = true;

  @override
  final String titleText = 'صفحه ورود';

  @override
  final String secondTextFormFieldLabel = 'رمز عبور';

  @override
  final String submitButtonLabel = 'ورود';

  @override
  Future<void> submitButtonOnPressed() async {
    showIndicator.value = true;
    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        Either<String, UserViewModel?> result = await repository.findUser(
          findUserDTO: FindUserDTO(
            username: usernameController.text,
            password: secondTextFieldController.text,
          ),
        );
        result.fold(
          (l) => validatorsMessage = 'مشکل در ارتباط با سرور',
          (r) {
            foundUser = r;
            if (r != null) {
              validatorsMessage = null;
            } else if (foundUser == null) {
              validatorsMessage = 'کاربری با این نام و رمز یافت نشد';
            }
          },
        );
        if (mainFormKey.currentState!.validate()) {
          if (rememberMeCheckBoxValue.value) {
            await box.write('savedUser_username', foundUser?.username);
            await box.write('savedUser_password', foundUser?.password);
          }
          if (foundUser!.isAdmin) {
            Get.offAndToNamed(
              FoodAppPageRoutes.adminHomePage,
              arguments: foundUser,
            );
          } else {
            Get.offAndToNamed(
              FoodAppPageRoutes.userHomePage,
              arguments: foundUser,
            );
          }
        }
        showIndicator.value = false;
      },
    );
  }
}
