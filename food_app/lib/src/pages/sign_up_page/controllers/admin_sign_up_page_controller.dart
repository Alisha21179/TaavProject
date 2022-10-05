import 'package:food_app/src/infrastructure/commons/models/user_view_model.dart';

import 'sign_up_page_base_controller.dart';

class AdminSignUpPageController extends SignUpPageBaseController {
  @override
  String pageTitle = 'ثبت نام(ادمین)';

  @override
  Future<void> submitButton() async {
    if (super.mainFormKey.value.currentState!.validate()) {
      UserViewModel adminViewModel = UserViewModel(
        isAdmin: true,
        name: nameController.text,
        family: familyController.text,
        address: addressController.text,
        birthday: '${birthYearController.text}/${birthMonthController.text}/${birthdayController.text}',
        phoneNumber: phoneNumberController.text,
        username: usernameController.text,
        password: passwordController.text,
      );
    }
  }

}
