import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:food_app/food_app.dart';
import 'package:get/get.dart';

import '../../../infrastructure/commons/models/user_view_model.dart';
import '../repositories/sign_up_page_repository.dart';

abstract class SignUpPageBaseController extends GetxController {
  final GlobalKey<FormState> mainFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthdayController = TextEditingController(text: 'روز');
  TextEditingController birthMonthController =
      TextEditingController(text: 'ماه');
  TextEditingController birthYearController =
      TextEditingController(text: 'سال');
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final SignUpPageRepository _repository = SignUpPageRepository();
  abstract String pageTitle;
  abstract bool thisControllerIsForAdmin;
  String? getUserEitherError;
  final List<UserViewModel> userList = [];
  RxBool showIndicator = false.obs;
  RxBool passwordIsObSecure = true.obs;
  RxBool confirmPasswordIsObSecure = true.obs;

  Future<void> getUserList() async {
    Either<String, List<UserViewModel>> getUserListEither =
        await _repository.getUser();
    getUserListEither.fold(
      (l) => getUserEitherError = l,
      (r) {
        getUserEitherError = null;
        userList.addAllIf(r.isNotEmpty, r);
      },
    );
  }

  Future<void> submitButtonValidate() async {
    showIndicator.value = true;
    await _indicatorController(
      duringIndication: () async {
        await getUserList();
        await Future.delayed(
          const Duration(seconds: 1),
          () async {
            if (mainFormKey.currentState!.validate()) {
              UserViewModel adminViewModel = UserViewModel(
                isAdmin: thisControllerIsForAdmin,
                name: nameController.text,
                family: familyController.text,
                address: addressController.text,
                birthday:
                    '${birthYearController.text}/${birthMonthController.text}/${birthdayController.text}',
                phoneNumber: phoneNumberController.text,
                username: usernameController.text,
                password: passwordController.text,
              );
              await _repository.signItUpToServer(adminViewModel);
              Get.offAndToNamed(FoodAppPageRoutes.loginPage);
            }
          },
        );
      },
    );
    showIndicator.value = false;
  }

  Future<void> _indicatorController(
      {Future<void>? Function()? duringIndication}) async {
    showIndicator.value = true;
    duringIndication != null ? await duringIndication() : null;
    await Future.delayed(
      const Duration(seconds: 1),
    ).then((value) => showIndicator.value = false);
  }

  String? usernameValidator(String? value) {
    String? usernameValidatorMessage;
    if (getUserEitherError != null) {
      usernameValidatorMessage = 'مشکل در ارتباط با سرور، دوباره امتحان کنید';
    }
    if (userList.isNotEmpty) {
      for (UserViewModel element in userList) {
        if (element.username == value) {
          usernameValidatorMessage = 'نام کابری قبلا انتخاب شده است';
        }
      }
    }
    if (value == null || value.trim().isEmpty) {
      usernameValidatorMessage = 'الزامی';
    }

    return usernameValidatorMessage;
  }

  String? nameValidator(String? value, {required String message}) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return message;
  }

  String? phoneNumberValidator(String? value) {
    List<String> validateList = [];
    if (value != null && int.tryParse(value) != null) {
      for (int i = 0; i < value.length; i++) {
        validateList.add(value[i]);
      }
    }
    if (value != null && validateList.isNotEmpty) {
      if (int.tryParse(validateList[0]) != 0) {
        return 'با عدد 0 شروع کنید';
      }
    }
    if (value == null || value.length != 11) {
      return 'شماره موبایل باید 11 رقم باشد';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (passwordController.text != confirmPasswordController.text) {
        return 'با رمزعبور مغایرت دارد';
      } else {
        return null;
      }
    } else if (value == null || value.trim().isEmpty) {
      return 'الزامی';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (value.length < 8) {
        return 'رمز عبور باید حداقل 8 رقم باشد';
      }
      if (confirmPasswordController.text.trim().isEmpty) {
        return 'لطفا فیلد تایید رمز را پر کنید';
      }
      if (value.contains(
            RegExp(r'[A-Za-z]'),
          ) &&
          value.contains(
            RegExp(r'[0-9]'),
          )) {
        return null;
      } else {
        return 'رمزعبور باید ترکیب عدد و حروف انگلیسی باشد';
      }
    } else if (value == null || value.trim().isEmpty) {
      return 'الزامی';
    }
    return null;
  }
}
