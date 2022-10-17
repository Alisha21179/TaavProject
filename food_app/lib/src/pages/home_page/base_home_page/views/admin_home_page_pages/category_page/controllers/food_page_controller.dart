import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../models/admin_page_base_insert_dto.dart';
import '../models/food_page_models/food_edit_dto.dart';
import '../models/food_page_models/food_insert_dto.dart';
import '../repositories/admin_page_base_repository.dart';
import '../repositories/food_page_repository.dart';
import 'admin_pages_base_controller.dart';

class AdminFoodPageController extends AdminPagesBaseController {
  @override
  TextEditingController searchBoxController = TextEditingController();

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
  Future<void> addNewItemDialogSubmitButton(
    BuildContext context, {
    required AdminPageBaseInsertDTO insertDTO,
  }) async {
    bool addedSuccessFully = false;
    FoodInsertDTO castedToFoodInsertDTO = insertDTO as FoodInsertDTO;
    if (insertDTO.title.trim().isNotEmpty &&
        insertDTO.foodIngredient.trim().isNotEmpty) {
      addedSuccessFully = await addItemToServer(
        insertDTO: castedToFoodInsertDTO,
      );
      if (addedSuccessFully) {
        getPageItemList();
        Navigator.pop(context);
        // await Get.offNamedUntil(
        //     FoodAppPageRoutes.adminHomePage, (route) => true);
      }
    }
  }

  @override
  Future<void> fABOnTapAddNewItem(BuildContext context) async {
    TextEditingController foodIngredientController = TextEditingController();
    TextEditingController foodNameController = TextEditingController();
    String? foodImageBase64String;
    customShowDialog(
      context,
      beforeCallingDialog: () {},
      title: const Text('افزودن غذا'),
      children: [
        customTextFormField(
          labelText: 'عنوان غذا',
          textInputAction: TextInputAction.done,
          controller: foodNameController,
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
            foodImageBase64String = await addImageInkwellOnTap();
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
                  FoodInsertDTO foodInsertDTO = FoodInsertDTO(
                      title: foodNameController.text,
                      foodIngredient: foodIngredientController.text,
                      foodBase64Image: foodImageBase64String);
                  await addNewItemDialogSubmitButton(
                    context,
                    insertDTO: foodInsertDTO,
                  );
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

  @override
  Future<void> editOnTap(
    BuildContext context, {
    required AdminPagesItemViewModel viewModel,
  }) async {
    FoodViewModel foodViewModel = viewModel as FoodViewModel;

    TextEditingController editFoodNameController =
        TextEditingController(text: foodViewModel.title);
    TextEditingController editFoodFoodIngredientController =
        TextEditingController(text: foodViewModel.foodIngredient);
    RxnString foodImageBase64String =
        RxnString(foodViewModel.imageBase64String);

    customShowDialog(
      context,
      title: const Text('ویرایش غذا'),
      children: [
        customTextFormField(
          labelText: 'عنوان غذا',
          textInputAction: TextInputAction.done,
          controller: editFoodNameController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        customTextFormField(
            labelText: 'مواد تشکیل دهنده‌ی غذا',
            textInputAction: TextInputAction.done,
            controller: editFoodFoodIngredientController,
            validator: dialogTitleFieldValidator,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1),
        Utils.smallVerticalSpace,
        Obx(
          () => InkWell(
            splashColor: Theme.of(context).primaryColor,
            onTap: () async {
              String? chosenImageBase64 = await addImageInkwellOnTap();
              if (chosenImageBase64 != null) {
                foodImageBase64String.value = chosenImageBase64;
              }
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
                  'ویرایش تصویر دسته‌بندی',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Expanded(child: Utils.mereSizedBox),
                SizedBox(
                  height: 40,
                  child: foodImageBase64String.value != null
                      ? Image.memory(
                          base64Decode(foodImageBase64String.value!),
                          fit: BoxFit.fitHeight,
                        )
                      : Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ],
            ),
          ),
        ),
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  FoodEditDTO foodEditDTO = FoodEditDTO(
                    foodIngredient: editFoodFoodIngredientController.text,
                    title: editFoodNameController.text,
                    imageBase64String: foodImageBase64String.value,
                  );
                  await editDialogSubmitButtonOnTap(
                    editDTO: foodEditDTO,
                    foodId: foodViewModel.id,
                  );
                  await getPageItemList();
                  Navigator.pop(context);
                },
                child: const Text('ثبت'),
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

  Future<void> editDialogSubmitButtonOnTap(
      {required int foodId, required FoodEditDTO editDTO}) async {
    Either<String, bool> result = await repository.editAdminItemInServer(
      adminItemId: foodId,
      editDTO: editDTO,
    );
    result.fold(
      (l) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'مشکل در افزودن در پایگاه داده',
            duration: Duration(seconds: 2),
            backgroundGradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.redAccent,
                Colors.deepOrange,
                Colors.deepOrangeAccent,
                Colors.orange,
                Colors.amber,
              ],
            ),
          ),
        );
      },
      (r) {
        if (r) {
          Get.showSnackbar(
            const GetSnackBar(
              message: 'با موفقیت ثبت شد',
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              message: 'با مشکل مواجه شد',
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }
}
