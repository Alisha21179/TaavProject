import 'package:flutter/material.dart';
import 'package:food_app/src/components/background_stack.dart';
import 'package:food_app/src/components/text_form_field.dart';
import 'package:get/get.dart';

import '../../../../components/custom_circular_indicator.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../controllers/login_page_base_controller.dart';

class LoginPageView<T extends LoginPageBaseController> extends GetView<T> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundStack(
      widgetList: [
        SafeArea(
          child: Container(
            color: Colors.white.withOpacity(0.4),
            child: ListView(
              padding: const EdgeInsets.only(
                top: Utils.giantSpace,
                right: Utils.largeSpace,
                left: Utils.largeSpace,
                bottom: Utils.largeSpace,
              ),
              children: [
                Center(
                  child: Form(
                    key: controller.mainFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Utils.giantVerticalSpace,
                        _titleText(context),
                        Utils.giantVerticalSpace,
                        _usernameTextFormField(),
                        Utils.giantVerticalSpace,
                        _secondTextFormField(),
                        Utils.smallVerticalSpace,
                        controller.showRememberMeCheckBox
                            ? _rememberMe(context)
                            : Utils.mereSizedBox,
                        Utils.smallVerticalSpace,
                        _submitButton(),
                        Utils.giantVerticalSpace,
                        controller.showForgotPassword
                            ? _forgotPassword(context)
                            : Utils.mereSizedBox,
                        Utils.mediumVerticalSpace,
                        controller.showSignup
                            ? _signUp(context)
                            : Utils.mereSizedBox,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rememberMe(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: controller.rememberMeCheckBoxValue.value,
            onChanged: controller.checkBoxOnTap,
          ),
          Text(
            'مرا به خاطر بسپار',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUp(BuildContext context) {
    return _clickableText(
      context,
      label: 'ثبت نام کنید',
      onTap: controller.signUp,
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return _clickableText(context,
        label: 'رمز عبور خود را فراموش کرده اید؟',
        onTap: controller.forgotPassword);
  }

  Widget _clickableText(BuildContext context,
      {required String label, required void Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Obx(
      () => _extractedSubmitButton(
        label: controller.submitButtonLabel,
        controller: controller,
      ),
    );
  }

  Widget _extractedSubmitButton({
    required String label,
    required LoginPageBaseController controller,
  }) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 1,
            color: Color.fromRGBO(148, 6, 6, 1.0),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitButtonOnPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Utils.smallHorizontalSpace,
            controller.showIndicator.value
                ? customCircularIndicator()
                : Utils.mereSizedBox,
          ],
        ),
      ),
    );
  }

  Widget _secondTextFormField() {
    return Obx(
      () => customTextFormField(
        textInputAction: TextInputAction.done,
        controller: controller.secondTextFieldController,
        labelText: controller.secondTextFormFieldLabel,
        isObSecure: controller.passwordIsObSecure.value,
        suffixIcon: controller.secondTextFormFieldIsObSecure
            ? obSecureSuffixIcon(isObSecure: controller.passwordIsObSecure)
            : null,
        validator: controller.passwordValidator,
        maxLines: 1
      ),
    );
  }

  Widget _usernameTextFormField() {
    return customTextFormField(
      textInputAction: TextInputAction.next,
      controller: controller.usernameController,
      labelText: 'نام کاربری',
      validator: controller.usernameValidator,
      maxLines: 1
    );
  }

  Widget _titleText(BuildContext context) {
    return Text(
      controller.titleText,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
