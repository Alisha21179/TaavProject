import 'package:flutter/material.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import 'package:food_app/src/infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import 'package:get/get.dart';

import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../models/category_page_models/category_insert_dto.dart';
import '../repositories/admin_page_base_repository.dart';
import '../repositories/category_page_repository.dart';
import 'admin_pages_base_controller.dart';

class AdminCategoryPageController extends AdminPagesBaseController {
  @override
  TextEditingController searchBoxController = TextEditingController();

  @override
  AdminPagesBaseRepository repository = CategoryPageRepository();

  @override
  List<Widget> Function(AdminPagesItemViewModel viewModel) infoLines =
      (viewModel) {
    viewModel as CategoryViewModel;
    return [
      Text(
        viewModel.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ];
  };

  @override
  Future<void> dialogSubmitButton(BuildContext context) async {
    bool addedSuccessFully = false;
    if (addItemDialogTitleTextFieldController.text.isNotEmpty) {
      CategoryInsertDTO insertDTO = CategoryInsertDTO(
        foodList: [],
        title: addItemDialogTitleTextFieldController.text,
        imageBase64String: imageBase64String,
      );
      addedSuccessFully = await addItemToServer(insertDTO: insertDTO);
      if (addedSuccessFully) {
        getPageItemList();
        // Navigator.pop(context);
        Get.offNamedUntil(FoodAppPageRoutes.adminHomePage, (route) => true);
      }
    }
  }

  @override
  Future<void> fABOnTap(BuildContext context) async {
    imageBase64String = null;

    customShowDialog(
      context,
      beforeCallingDialog: () {
        addItemDialogTitleTextFieldController.text = '';
      },
      title: const Text('افزودن دسته‌بندی'),
      children: [
        customTextFormField(
          labelText: 'عنوان دسته بندی',
          textInputAction: TextInputAction.done,
          controller: addItemDialogTitleTextFieldController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: () async {
            await addImageInkwellOnTap(
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
                  await dialogSubmitButton(context);
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
