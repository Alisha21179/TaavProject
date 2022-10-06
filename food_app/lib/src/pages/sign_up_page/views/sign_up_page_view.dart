import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../components/background_stack.dart';
import '../../../infrastructure/utils/utils.dart';
import '../commons/birth_date_list.dart';
import '../controllers/sign_up_page_base_controller.dart';

class SignUpPage<T extends SignUpPageBaseController> extends GetView<T> {
  const SignUpPage({Key? key}) : super(key: key);

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
                Form(
                  key: controller.mainFormKey,
                  child: Column(
                    children: [
                      _titleText(context),
                      Utils.giantVerticalSpace,
                      _nameTextField(),
                      Utils.largeVerticalSpace,
                      _familyTextField(),
                      Utils.largeVerticalSpace,
                      _addressTextField(),
                      Utils.largeVerticalSpace,
                      _birthdayRow(),
                      Utils.largeVerticalSpace,
                      _phoneNumberTextField(),
                      Utils.largeVerticalSpace,
                      _userNameTextField(),
                      Utils.largeVerticalSpace,
                      _passwordTextField(),
                      Utils.largeVerticalSpace,
                      _confirmPasswordTextField(),
                      Utils.largeVerticalSpace,
                      _submitButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
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
      child: Obx(
        () => ElevatedButton(
          onPressed: () async {
            await controller.submitButtonValidate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ثبت',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Utils.smallHorizontalSpace,
              controller.showIndicator.value
                  ? _circularIndicator()
                  : Utils.mereSizedBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget _circularIndicator() {
    return const SizedBox(
      height: 40,
      // width: 40,
      child: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        strokeWidth: 5,
      ),
    );
  }

  Widget _confirmPasswordTextField() {
    return Obx(
      () => _textFormField(
        labelText: 'تایید رمزعبور',
        textInputAction: TextInputAction.done,
        controller: controller.confirmPasswordController,
        validator: (value) {
          return controller.confirmPasswordValidator(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        isObSecure: controller.confirmPasswordIsObSecure.value,
        suffixIcon: _isObSecureSuffixIcon(
            isObSecure: controller.confirmPasswordIsObSecure),
      ),
    );
  }

  Widget _isObSecureSuffixIcon({required RxBool isObSecure}) {
    return GestureDetector(
      child: isObSecure.value
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      onTap: () {
        isObSecure.value = !isObSecure.value;
      },
    );
  }

  Widget _passwordTextField() {
    return Obx(
      () => _textFormField(
        labelText: 'رمزعبور',
        textInputAction: TextInputAction.next,
        controller: controller.passwordController,
        validator: (value) {
          return controller.passwordValidator(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        isObSecure: controller.passwordIsObSecure.value,
        suffixIcon:
            _isObSecureSuffixIcon(isObSecure: controller.passwordIsObSecure),
      ),
    );
  }

  Widget _userNameTextField() {
    return _textFormField(
      labelText: 'نام کاربری',
      textInputAction: TextInputAction.next,
      controller: controller.usernameController,
      validator: (value) {
        return controller.usernameValidator(value);
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _phoneNumberTextField() {
    return _textFormField(
      hintText: '*********09',
      labelText: 'شماره موبایل',
      maxLength: 11,
      textInputAction: TextInputAction.next,
      controller: controller.phoneNumberController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
      ],
      validator: (value) {
        return controller.phoneNumberValidator(value);
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _addressTextField() {
    return _textFormField(
      labelText: 'آدرس',
      textInputAction: TextInputAction.next,
      controller: controller.addressController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        return controller.nameValidator(
          value,
          message: 'آدرس الزامیست',
        );
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _familyTextField() {
    return _textFormField(
      labelText: 'نام خانوادگی',
      textInputAction: TextInputAction.next,
      controller: controller.familyController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp(r"[ا-یA-Za-z]"), allow: true)
      ],
      validator: (value) {
        return controller.nameValidator(
          value,
          message: 'نام خانوادگی الزامیست',
        );
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _nameTextField() {
    return _textFormField(
      labelText: 'نام',
      textInputAction: TextInputAction.next,
      controller: controller.nameController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp(r"[ا-یA-Za-z]"), allow: true)
      ],
      validator: (value) {
        return controller.nameValidator(
          value,
          message: 'نام الزامی است',
        );
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _birthdayRow() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.9,
              color: Colors.grey.withOpacity(0.5),
            ),
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: _formDropdownButton(
                    itemBuildList: birthdayMenu,
                    controller: controller.birthdayController,
                  ),
                ),
                Utils.smallHorizontalSpace,
                Expanded(
                  child: _formDropdownButton(
                    itemBuildList: birthMonthMenu,
                    controller: controller.birthMonthController,
                  ),
                ),
                Utils.smallHorizontalSpace,
                Expanded(
                  child: _formDropdownButton(
                    itemBuildList: birthYearMenu,
                    controller: controller.birthYearController,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: -13,
          right: 10,
          child: Text(
            'تاریخ تولد',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _formDropdownButton(
      {required List<String> itemBuildList,
      required TextEditingController controller}) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
      ),
      items: itemBuildList
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (value) {
        controller.text = value!;
      },
      hint: Text(controller.text),
      isDense: true,
      selectedItemBuilder: (context) {
        return itemBuildList.map((e) => Text(e)).toList();
      },
      menuMaxHeight: 300,
      validator: (value) {
        if (value != null && itemBuildList.contains(value)) {
          return null;
        }
        return 'الزامی';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _textFormField({
    String? labelText,
    required TextInputAction textInputAction,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String? value)? validator,
    TextInputType? keyboardType,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    String? hintText,
    bool isObSecure = false,
    Widget? suffixIcon,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white.withOpacity(0.5),
      ),
      child: TextFormField(
        obscureText: isObSecure,
        maxLength: maxLength,
        textInputAction: textInputAction,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          counterText: '',
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(width: 0.3),
          ),
          label: labelText != null
              ? Text(
                  labelText,
                  style: TextFormFieldUtils.textStyleSize20,
                )
              : null,
        ),
        inputFormatters: inputFormatters,
        validator: validator,
        keyboardType: keyboardType,
        autovalidateMode: autoValidateMode,
      ),
    );
  }

  Widget _titleText(BuildContext context) {
    return Text(
      controller.pageTitle,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
