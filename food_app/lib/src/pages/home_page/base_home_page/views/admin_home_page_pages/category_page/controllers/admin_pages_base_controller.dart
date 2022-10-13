import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import '../../../../../../../infrastructure/utils/image_utils.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../models/category_page_models/category_insert_dto.dart';
import '../repositories/admin_page_base_repository.dart';

abstract class AdminPagesBaseController extends GetxController {
  TextEditingController addCategoryDialogTitleTextField =
      TextEditingController();
  abstract TextEditingController searchBoxController;
  final AdminPagesBaseRepository repository = AdminPagesBaseRepository();
  final ImagePicker imagePicker = ImagePicker();
  String? itemListServerProblem;
  String? imageBase64String;
  Rx<List<CategoryViewModel>> categoryList = Rx([]);

  @override
  void onInit() {
    getPageItemList();
    super.onInit();
  }

  Future<void> getPageItemList() async {
    Either<String, List<CategoryViewModel>> result =
        await repository.getCategoryList();
    result.fold(
      (l) {
        itemListServerProblem = 'مشکل در ارتباط با سرور';
      },
      (r) {
        categoryList.value = r;
        itemListServerProblem = null;
      },
    );
  }

  Future<bool> addCategoryToServer(
      {required CategoryInsertDTO insertDTO}) async {
    bool addedSuccessFully = false;
    Either<String, bool> result =
        await repository.createNewCategory(insertDTO: insertDTO);
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
          addedSuccessFully = true;
          Get.showSnackbar(
            const GetSnackBar(
              message: 'با موفقیت اضافه شد',
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
    return addedSuccessFully;
  }

  Future<void> addImageInkwellOnTap(
      {required void Function(Uint8List imageBytes) imageBytesHandler}) async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageBase64String = await ImageUtils.xFileToBase64String(
        imageXFile: image,
      );
    } else {
      imageBase64String = null;
    }
  }

  Future<void> dialogSubmitButton(BuildContext context) async {
    bool addedSuccessFully = false;
    if (addCategoryDialogTitleTextField.text.isNotEmpty) {
      CategoryInsertDTO insertDTO = CategoryInsertDTO(
        foodList: [],
        title: addCategoryDialogTitleTextField.text,
        imageBase64String: imageBase64String,
      );
      addedSuccessFully = await addCategoryToServer(insertDTO: insertDTO);
      if (addedSuccessFully) {
        getPageItemList();
        Get.back();
      }
    }
  }

  Future<void> deleteButtonOnTap(int categoryId) async {
    Either<String, bool> result =
        await repository.deleteCategoryFromServer(categoryId);
    result.fold(
      (l) => itemListServerProblem = 'مشکل در ارتباط با سرور',
      (r) {
        if (r) {
          getPageItemList();
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

  Future<void> fABOnTap(BuildContext context) async {
    imageBase64String = null;

    customShowDialog(
      context,
      beforeCallingDialog: () {
        addCategoryDialogTitleTextField.text = '';
      },
      title: const Text('افزودن دسته‌بندی'),
      children: [
        customTextFormField(
          textInputAction: TextInputAction.done,
          controller: addCategoryDialogTitleTextField,
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

  String? dialogTitleFieldValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'بدون ورودی چیزی اضافه نمی‌شود';
    }
    if (value.trim().length < 3) {
      return 'بیشتر از سه حرف وارد کنید';
    }
    return null;
  }
}
