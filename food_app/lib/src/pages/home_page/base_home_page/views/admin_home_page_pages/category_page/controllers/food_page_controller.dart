import 'package:flutter/material.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/food_page_models/food_insert_dto.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/repositories/admin_page_base_repository.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/repositories/food_page_repository.dart';
import 'package:get/get.dart';

import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import 'admin_pages_base_controller.dart';

class AdminFoodPageController extends AdminPagesBaseController {
  @override
  TextEditingController searchBoxController = TextEditingController();

  TextEditingController foodIngredientController = TextEditingController();

  @override
  AdminPagesBaseRepository repository = FoodPageRepository();

  @override
  List<Widget> Function(AdminPagesItemViewModel viewModel) infoLines =
      (viewModel) {
    viewModel as FoodViewModel;
    return [
      Text(
        viewModel.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Utils.smallVerticalSpace,
      SizedBox(
        height: 50,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [Text(viewModel.foodIngredient)],
          ),
        ),
      )
    ];
  };

  @override
  Future<void> dialogSubmitButton(BuildContext context) async {
    bool addedSuccessFully = false;
    if (addItemDialogTitleTextFieldController.text.trim().isNotEmpty &&
        foodIngredientController.text.trim().isNotEmpty) {
      FoodInsertDTO insertDTO = FoodInsertDTO(
        title: addItemDialogTitleTextFieldController.text,
        foodBase64Image: imageBase64String,
        foodIngredient: foodIngredientController.text,
      );
      addedSuccessFully = await addItemToServer(insertDTO: insertDTO);
      if (addedSuccessFully) {
        getPageItemList();
        Navigator.pop(context);
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
        foodIngredientController.text = '';
      },
      title: const Text('افزودن غذا'),
      children: [
        customTextFormField(
          labelText: 'عنوان غذا',
          textInputAction: TextInputAction.done,
          controller: addItemDialogTitleTextFieldController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        customTextFormField(
            labelText: 'مواد تشکیل دهنده‌ی غذا',
            textInputAction: TextInputAction.done,
            controller: foodIngredientController,
            validator: dialogTitleFieldValidator,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1),
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
                'افزودن تصویر غذا',
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
