import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../infrastructure/commons/models/user_view_model.dart';
import '../models/find_user_dto.dart';
import 'login_page_base_controller.dart';

class ForgotPassController extends LoginPageBaseController{
  @override
  RxBool passwordIsObSecure= false.obs;

  @override
  final bool secondTextFormFieldIsObSecure=false;

  @override
  final bool showForgotPassword=false;

  @override
  final bool showRememberMeCheckBox=false;

  @override
  final bool showSignup=false;

  @override
  final String titleText= 'بازیابی رمز';

  @override
  final String secondTextFormFieldLabel= 'شماره موبایل';

  @override
  final String submitButtonLabel='تغییر رمز';

  @override
  Future<void> submitButtonOnPressed() async {
    showIndicator.value = true;
    await Future.delayed(
      const Duration(seconds: 2),
          () async {
        Either<String, UserViewModel?> result = await repository.findUser(
          findUserDTO: FindUserDTO(
            username: usernameController.text,
            phoneNumber: secondTextFieldController.text,
          ),
        );
        result.fold(
              (l) => validatorsMessage = 'مشکل در ارتباط با سرور',
              (r) {
            foundUser = r;
            if (foundUser!= null) {
              validatorsMessage = null;
            } else if (foundUser == null) {
              validatorsMessage = 'کاربری با این نام و رمز یافت نشد';
            }
          },
        );
        if (mainFormKey.currentState!.validate()) {}
        showIndicator.value = false;
      },
    );
  }

}