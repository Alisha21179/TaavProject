import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/category_page_models/category_edit_dto.dart';
import 'package:get/get.dart';

import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
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
        await Get.offNamedUntil(
            FoodAppPageRoutes.adminHomePage, (route) => true);
      }
    }
  }

  @override
  Future<void> fABOnTap(BuildContext context) async {
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
            imageBase64String = await addImageInkwellOnTap();
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
    imageBase64String = null;
  }

  @override
  Future<void> editOnTap(
    BuildContext context, {
    required AdminPagesItemViewModel viewModel,
  }) async {
    CategoryViewModel categoryViewModel = viewModel as CategoryViewModel;
    TextEditingController editItemDialogTitleTextFieldController =
        TextEditingController(text: categoryViewModel.title);
    Rxn<String> editDialogImageBase64 = Rxn(categoryViewModel.imageBase64String);
    customShowDialog(
      context,
      title: const Text('ویرایش دسته‌بندی '),
      children: [
        customTextFormField(
          labelText: 'عنوان دسته بندی',
          textInputAction: TextInputAction.done,
          controller: editItemDialogTitleTextFieldController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        Obx(() => InkWell(
              splashColor: Theme.of(context).primaryColor,
              onTap: () async {
                String? chosenImageBase64;
                chosenImageBase64 = await addImageInkwellOnTap();
                if (chosenImageBase64 != null) {
                  editDialogImageBase64.value = chosenImageBase64;
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
                    child: editDialogImageBase64.value != null
                        ? Image.memory(
                            base64Decode(editDialogImageBase64.value!),
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
            )),
        Utils.mediumVerticalSpace,
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  CategoryEditDTO editDTO = CategoryEditDTO(
                    foodList: [],
                    title: editItemDialogTitleTextFieldController.text,
                    imageBase64String: editDialogImageBase64.value,
                  );
                  await editDialogSubmitButtonOnTap(
                      categoryId: categoryViewModel.id, editDTO: editDTO);
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
      {required int categoryId, required CategoryEditDTO editDTO}) async {
    Either<String, bool> result = await repository.editAdminItemInServer(
      adminItemId: categoryId,
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
