import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/utils/image_utils.dart';
import '../models/admin_page_base_insert_dto.dart';
import '../repositories/admin_page_base_repository.dart';

abstract class AdminPagesBaseController extends GetxController {
  TextEditingController addItemDialogTitleTextFieldController =
      TextEditingController();
  abstract TextEditingController searchBoxController;
  abstract final AdminPagesBaseRepository repository;
  abstract final List<Widget> Function(
    AdminPagesItemViewModel viewModel,
  ) infoLines;
  final ImagePicker imagePicker = ImagePicker();
  String? itemListServerProblem;
  String? imageBase64String;
  Rx<List<AdminPagesItemViewModel>> itemList = Rx([]);

  @override
  void onInit() {
    getPageItemList();
    super.onInit();
  }

  Future<void> getPageItemList() async {
    Either<String, List<AdminPagesItemViewModel>> result =
        await repository.getItemList();
    result.fold(
      (l) {
        itemListServerProblem = 'مشکل در ارتباط با سرور';
      },
      (r) {
        itemList.value = r;
        itemListServerProblem = null;
      },
    );
  }

  Future<bool> addItemToServer<T extends AdminPageBaseInsertDTO>(
      {required T insertDTO}) async {
    bool addedSuccessFully = false;
    Either<String, bool> result =
        await repository.createNewItem(insertDTO: insertDTO);
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

  Future<void> dialogSubmitButton(BuildContext context);

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

  Future<void> fABOnTap(BuildContext context);

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
