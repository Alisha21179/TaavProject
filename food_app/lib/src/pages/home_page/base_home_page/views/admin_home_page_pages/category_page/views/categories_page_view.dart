import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/src/components/category_page_components/category_list_view_item.dart';
import 'package:get/get.dart';

import '../../../../../../../components/search_box.dart';
import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../controllers/categories_page_controller.dart';
import '../models/category_insert_dto.dart';

class CategoriesPageView extends StatelessWidget {
  CategoriesPageView({Key? key}) : super(key: key);

  final CategoriesPageController _controller = Get.put(
    CategoriesPageController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.4),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: const Icon(Icons.add),
        onPressed: () async {
          await _fABOnTap(context);
        },
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _controller.getCategoryList();
      },
      child: Obx(
        () => Column(
          children: [
            Utils.tinyVerticalSpace,
            customSearchBox(
              context,
              advancedButtonOnTap: () {},
              searchBoxValidator: (value) {},
              searchBoxController: _controller.searchBoxController,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(
                  Utils.smallSpace,
                ),
                itemCount: _controller.categoryList.value.length,
                itemBuilder: (context, index) {
                  return CategoryListItem(
                    viewModel: _controller.categoryList.value[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fABOnTap(BuildContext context) async {
    customShowDialog(
      context,
      beforeCallingDialog: () {
        _controller.addCategoryDialogTitleTextField.text = '';
      },
      title: const Text('افزودن دسته‌بندی'),
      children: [
        customTextFormField(
          textInputAction: TextInputAction.done,
          controller: _controller.addCategoryDialogTitleTextField,
          validator: _controller.dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: () async {
            await _controller.addImageInkwellOnTap(
              imageBytesHandler: (imageBytes) {},
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.image,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              Utils.smallHorizontalSpace,
              const Text(
                'افزودن تصویر دسته‌بندی',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await _controller.dialogSubmitButton(context);
                },
                child: const Text('افزودن'),
              ),
            ),
            Utils.mediumHorizontalSpace,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('لغو'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
