import 'package:flutter/material.dart';

import '../infrastructure/utils/utils.dart';
import 'text_form_field.dart';

Widget customSearchBox(
    BuildContext context, {
      required void Function() advancedButtonOnTap,
      required String? Function(String? value) searchBoxValidator,
      required TextEditingController searchBoxController,
    }) {
  return Row(
    children: [
      Utils.smallHorizontalSpace,
      Expanded(
        child: customTextFormField(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.done,
          controller: searchBoxController,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          validator: searchBoxValidator,
        ),
      ),
      IconButton(
        onPressed: advancedButtonOnTap,
        icon: Icon(
          Icons.tune,
          color: Theme.of(context).primaryColor,
        ),
      ),
      Utils.smallHorizontalSpace,
    ],
  );
}
