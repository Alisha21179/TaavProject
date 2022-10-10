import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../infrastructure/utils/utils.dart';

Widget customTextFormField({
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
  Widget? prefixIcon,
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
        prefixIcon: prefixIcon,
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

Widget obSecureSuffixIcon({required RxBool isObSecure}) {
  return GestureDetector(
    child: isObSecure.value
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off),
    onTap: () {
      isObSecure.value = !isObSecure.value;
    },
  );
}
